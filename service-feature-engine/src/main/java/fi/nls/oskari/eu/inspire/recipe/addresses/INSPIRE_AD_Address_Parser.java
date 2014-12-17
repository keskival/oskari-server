package fi.nls.oskari.eu.inspire.recipe.addresses;

import java.io.IOException;

import com.vividsolutions.jts.geomgraph.Position;

import fi.nls.oskari.eu.inspire.addresses.INSPIRE_ad_Address.Address;
import fi.nls.oskari.fe.input.format.gml.recipe.JacksonParserRecipe.GML32;
import fi.nls.oskari.fe.iri.Resource;

public class INSPIRE_AD_Address_Parser extends GML32 {

    @Override
    public void parse() throws IOException {

        final FeatureOutputContext outputContext = new FeatureOutputContext(
                Address.QN);

        final Resource geom = outputContext.addDefaultGeometryProperty();
        final Resource beginLifespanVersion = outputContext
                .addOutputStringProperty("beginLifespanVersion");
        final Resource inspireId = outputContext.addOutputProperty("inspireId");
        final Resource endLifespanVersion = outputContext
                .addOutputStringProperty("endLifespanVersion");
        final Resource obj = outputContext.addOutputStringProperty("obj");

        outputContext.build();

        final OutputFeature<Address> outputFeature = new OutputFeature<Address>(
                outputContext);

        final InputFeature<Address> iter = new InputFeature<Address>(
                Address.QN, Address.class);

        while (iter.hasNext()) {
            final Address feature = iter.next();
            final Resource output_ID = outputContext.uniqueId(feature.id);

            outputFeature.setFeature(feature).setId(output_ID);

            if (!feature.position.isEmpty()) {

                if (feature.position.get(0).GeographicPosition != null
                        && feature.position.get(0).GeographicPosition.geometry != null) {
                    outputFeature
                            .addGeometryProperty(
                                    geom,
                                    feature.position.get(0).GeographicPosition.geometry.geometry);

                }
            }

            outputFeature
                    .addProperty(beginLifespanVersion,
                            feature.beginLifespanVersion)
                    .addProperty(inspireId, feature.inspireId)
                    .addProperty(endLifespanVersion, feature.endLifespanVersion);

            outputFeature.addProperty(obj, feature);

            outputFeature.build();

        }

    }

}
