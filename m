From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 6 Feb 2013 08:21:56 +0100
Subject: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
In-Reply-To: <20130205184014.GK25185@atomide.com>
References: <50FE64DC.2030808@ti.com> <510788B9.9050907@ti.com>
 <20130130220532.GA22517@atomide.com> <20130204195251.GS22517@atomide.com>
 <5110D4ED.6030306@ti.com> <20130205184014.GK25185@atomide.com>
Message-ID: <51120494.6020407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 07:40 PM, Tony Lindgren wrote:
>> For some reason the CONFIG_DEBUG_SECTION_MISMATCH got disabled in my rolling
>> kernel config...
> 
> At least gcc version 4.3.5 (Debian 4.3.5-4) shows them. What's
> the compiler you have? 

It show for me as well now that I have enabled the
CONFIG_DEBUG_SECTION_MISMATCH in my config.

My GCC is:
armv7a-hardfloat-linux-gnueabi-gcc (Gentoo 4.7.2 p1.3, pie-0.5.5) 4.7.2

> Yes let's do that rather than start copying things around. I'll apply
> the following fix to the omap-for-v3.9/twl branch.

Cool, thanks Tony. I will drop my patch and pick the one from omap-for-v3.9/twl.

Thanks,
P?ter
