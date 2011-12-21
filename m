From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Dec 2011 10:12:47 +0800
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111221013702.GB15398@opensource.wolfsonmicro.com>
References: <20111220020101.GD5683@S2100-06.ap.freescale.net>
 <20111220015931.GX2860@opensource.wolfsonmicro.com>
 <20111220030347.GB2995@S2101-09.ap.freescale.net>
 <20111220112510.GL2866@opensource.wolfsonmicro.com>
 <20111220135251.GB5129@S2101-09.ap.freescale.net>
 <20111220143558.GT2866@opensource.wolfsonmicro.com>
 <20111220153101.GD5348@S2101-09.ap.freescale.net>
 <20111220232526.GA6551@opensource.wolfsonmicro.com>
 <20111221012519.GA5983@S2101-09.ap.freescale.net>
 <20111221013702.GB15398@opensource.wolfsonmicro.com>
Message-ID: <20111221021246.GB5983@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 01:37:03AM +0000, Mark Brown wrote:
> On Wed, Dec 21, 2011 at 09:25:21AM +0800, Shawn Guo wrote:
> > The problem is even if we have the name defined that way, it has to be
> > matched to the name used in mc13892 driver somehow, if we want to use
> > name as the key to find the regulator defined in mc13892 driver as
> > array mc13892_regulators[].
> 
> This doesn't seem like a problem - the most obvious thing would just be
> to adjust the strings in the code to correspond to what the device tree
> binding says.
> 
Okay, that's it.  Something obvious to you is not obvious to me :)
As I'm migrating an existing driver to be DT aware, I'm trying to avoid
changing any non-dt code.  Your suggestion would be obvious to me if I'm
writing a new driver that only supports DT.

Anyway, I got your point, and will follow that since you seems fine
with changing non-dt code to adopt dt support.

-- 
Regards,
Shawn
