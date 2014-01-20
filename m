From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jan 2014 09:55:32 +0000
Subject: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
In-Reply-To: <CAOesGMiych-jeo_eKGgL1qxsYQ=rkb4UQwgGBsG-7+GMbLJWhg@mail.gmail.com>
References: <20140116182211.GX15937@n2100.arm.linux.org.uk>
 <20140119031816.GD16158@S2101-09.ap.freescale.net>
 <20140119185246.GB28056@quad.lixom.net>
 <20140120004434.GV15937@n2100.arm.linux.org.uk>
 <CAOesGMiych-jeo_eKGgL1qxsYQ=rkb4UQwgGBsG-7+GMbLJWhg@mail.gmail.com>
Message-ID: <20140120095532.GW15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:34:22PM -0800, Olof Johansson wrote:
> I'm guessing this is going to mess up Shawn's cleanup patches, but
> time has ran out for 3.14 for those so they will need to be respun
> anyway, most likely.
> 
> We can apply them to arm-soc's dt branch. I think it's better if we
> merge them since dts files tend to be one of the conflict-ridden areas
> (even if this particular instance isn't). Send the series our way if
> you want, or send a branch pull request, your choice.

There's no conflict, and they build fine according to my autobuilder
which includes arm-soc for-next.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
