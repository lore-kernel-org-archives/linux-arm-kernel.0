From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 Feb 2013 08:56:16 -0800
Subject: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
In-Reply-To: <51120494.6020407@ti.com>
References: <50FE64DC.2030808@ti.com> <510788B9.9050907@ti.com>
 <20130130220532.GA22517@atomide.com>
 <20130204195251.GS22517@atomide.com> <5110D4ED.6030306@ti.com>
 <20130205184014.GK25185@atomide.com> <51120494.6020407@ti.com>
Message-ID: <20130206165616.GW25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130205 23:25]:
> On 02/05/2013 07:40 PM, Tony Lindgren wrote:
> >> For some reason the CONFIG_DEBUG_SECTION_MISMATCH got disabled in my rolling
> >> kernel config...
> > 
> > At least gcc version 4.3.5 (Debian 4.3.5-4) shows them. What's
> > the compiler you have? 
> 
> It show for me as well now that I have enabled the
> CONFIG_DEBUG_SECTION_MISMATCH in my config.

Maybe update your build scripts to always just:
$ ARCH=arm CONFIG_DEBUG_SECTION_MISMATCH=y make ...
 
> My GCC is:
> armv7a-hardfloat-linux-gnueabi-gcc (Gentoo 4.7.2 p1.3, pie-0.5.5) 4.7.2
> 
> > Yes let's do that rather than start copying things around. I'll apply
> > the following fix to the omap-for-v3.9/twl branch.
> 
> Cool, thanks Tony. I will drop my patch and pick the one from omap-for-v3.9/twl.

OK will send that off today then.

Regards,

Tony
