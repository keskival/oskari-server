package fi.nls.oskari.domain.geo.comparator;

import java.util.Comparator;

import fi.nls.oskari.domain.geo.Point;

public class LatComparator implements Comparator<Point> {

    @Override
    public int compare(final Point arg0, final Point arg1) {
        final double diff = arg0.getLat() - arg1.getLat();

        if (diff < 0) {
            return -1;
        } else if (diff > 0) {
            return 1;
        }
        return 0;

    }

}
