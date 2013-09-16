From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 16 Sep 2013 21:10:32 +0300
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <20130916150147.GA14047@earth.universe>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
 <CAAwP0s0e-gYkNA78eQH7x2VJbM1byaisUeqU8YbbeWUbKwsxCQ@mail.gmail.com>
 <20130916150147.GA14047@earth.universe>
Message-ID: <20130916181032.GB30568@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 16, 2013 at 05:01:47PM +0200, Sebastian Reichel wrote:
> > Is the Synchronous Serial Interface (SSI)  only supported by
> > OMAP34xx/OMAP35xx SoC and not by OMAP36xx/OMAP37xx SoC?
> > 
> > I'm asking this since if SSI is supported by both we should add the
> > device nodes in omap3.dtsi instead of omap34xx.dtsi.
> > 
> > I thought that all OMAP3 SoC supported SSI and all OMAP4 SoC supported
> > HSI but I guess I was wrong...
> 
> I just do not know. Information about the SSI core is not included
> in the public OMAP TRM. It only lists the memory space as reserved.
> 
> Thus I only included it in OMAP34xx, which is used in Nokia N900 and
> must support SSI.

I think N9 and N950 (OMAP3630) are using pretty much the same driver.

A.
