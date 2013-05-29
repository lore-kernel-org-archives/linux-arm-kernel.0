From: jan.glauber@gmail.com (Jan Glauber)
Date: Wed, 29 May 2013 10:10:07 +0200
Subject: ARM hibernation / suspend-to-disk
Message-ID: <20130529081005.GA25561@hal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

what's the status of suspend-to-disk on ARM? The most recent discussion I
found is:
http://lists.linuxfoundation.org/pipermail/linux-pm/2012-November/034997.html

with no replies at all. Is anyone still working on that? Anyone got it running?

I tried the patch above (on top of LTS 3.4) and got stuck forever, the last
thing on the console was:

root at omap5:/sys/power# echo disk > state
[ 2015.641540] PM: Syncing filesystems ... done.
[ 2015.666870] PM: Preallocating image memory... done (allocated 16957 pages)
[ 2016.062011] PM: Allocated 67828 kbytes in 0.38 seconds (178.49 MB/s)

Any hint how to debug that?

thanks,
Jan
