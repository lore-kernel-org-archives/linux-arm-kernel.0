From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Apr 2014 22:00:00 +0800
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140403134510.GO7528@n2100.arm.linux.org.uk>
References: <deb03b2af59a4fe7a46bc66278335826@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402104644.GI7528@n2100.arm.linux.org.uk>
 <ebffe60db89d45ce883b1b9aff121152@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402165113.GJ7528@n2100.arm.linux.org.uk>
 <a52a4e6119c143799220667a25781844@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140403085636.GL7528@n2100.arm.linux.org.uk>
 <f5dfa7eca60346e884768bf821594d06@BY2PR03MB377.namprd03.prod.outlook.com>
 <20140403103206.GN7528@n2100.arm.linux.org.uk>
 <20140403133637.GB1784@dragon>
 <20140403134510.GO7528@n2100.arm.linux.org.uk>
Message-ID: <20140403135957.GE2786@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 02:45:10PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 03, 2014 at 09:36:41PM +0800, Shawn Guo wrote:
> > Russell,
> > 
> > In case there is a confusion.  The 900Mbps figure that Fugang said is
> > not on any of i.MX6 SoCs that are publicly available - i.MX6SoloLite
> > (imx6sl), i.MX6Solo/DualLite (imx6dl), i.MX6Dual/Quad (imx6q), but on
> > a new member of i.MX6 family - i.MX6SoloX (imx6sx).  This new SoC hasn't
> > been announced by Freescale yet.  One major improvement of this new SoC
> > over its ancestors is the FEC throughput.  It claims 1Gbps throughput
> > support.  So it's really a hardware optimization instead of anything
> > that software can do.
> 
> That means it's irrelevant to this discussion because it's different
> hardware, with who knows what changes to the memory subsystem and
> CPU/cache implementation.  Hence, it can't be compared in any way to
> the performance I see on iMX6Q and iMX6S.

Exactly.  I don't think that Fugang should bring i.MX6SX figure into the
discussion either, and I see that's where the confusion comes, from what
I read the thread today.

Shawn
