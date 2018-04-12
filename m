From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Apr 2018 14:52:01 +0100
Subject: [PATCH] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <CACRpkdaKc28xe1_iBd07qRsGig_yc0Kfm+ZRj8+t+Wd32uMK7w@mail.gmail.com>
References: <20180412131426.18011-1-linus.walleij@linaro.org>
 <20180412131737.GF16141@n2100.armlinux.org.uk>
 <20180412131845.GG16141@n2100.armlinux.org.uk>
 <CACRpkdaKc28xe1_iBd07qRsGig_yc0Kfm+ZRj8+t+Wd32uMK7w@mail.gmail.com>
Message-ID: <20180412135201.GH16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 03:44:58PM +0200, Linus Walleij wrote:
> On Thu, Apr 12, 2018 at 3:18 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Thu, Apr 12, 2018 at 02:17:37PM +0100, Russell King - ARM Linux wrote:
> >> Sorry, I haven't given up my maintainership, as I had already stated.
> >>
> >> NAK.
> >
> > Oh, sorry, yes, this is fine, this is just the reference platforms.
> > Please go ahread and pick them up.
> 
> Thanks Russell!
> 
> Do you still have some of the old ARM references around for the odd
> tests? I am thinking especially about the IB1 external display for Versatile
> that I haven't been able to locate for test, it'd be great to know if it
> works with Erik Anholt's DRM driver.

I've never had any of the external displays that plug into the connector
underneath the character LCD.  I did, at one time, have what was called
an PP2 which had a LCD display though.

I do have several boards - mainly a few varieties of Integrator CP
(including one with a stack of FPGA tiles containing bitstreams for
various development CPUs) - eg, ARM926 based SMP system which was
never merged into mainline.  Versatile PB926 and Realview EB.
The PB926 partly runs my test farm here.  The Versatile Express
CT9x4 is still part of the boot farm, and just about works with
certain kernels, but I'm pretty sure there's a cache latency bug
there (I carry patches privately to fix it, but it doesn't appear to
completely solve it.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
