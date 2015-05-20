From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 May 2015 19:25:41 +0100
Subject: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
In-Reply-To: <20150520015851.GB1071@dragon>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520015851.GB1071@dragon>
Message-ID: <20150520182540.GQ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 09:58:51AM +0800, Shawn Guo wrote:
> On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li at freescale.com wrote:
> > Frank Li (6):
> >   arm: imx: power-off: change to syscon to access register
> >   rtc: arm: imx: snvs: change use syscon to access register
> >   Document: dt: fsl: snvs: change support syscon
> >   arm: dts: imx: update snvs to use syscon access register
> >   document: devicetree: input: imx: i.mx snvs power device tree bindings
> >   arm: dts: imx6sx: enable snvs power key
> 
> So, the series will break existing DTBs for RTC and poweroff, right?
> If this is unavoidable, should we at least have some warning messages
> telling users about his breakage?

What's the justification for breaking existing DTBs?  Really, this is
something we should strive to avoid, _and_ actually avoid by providing
backwards compatibility.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
