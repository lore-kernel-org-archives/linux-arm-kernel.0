From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 02 Dec 2011 20:16:53 +0100
Subject: [PATCH] ARM: S3C64XX: Define some additional always off clocks
In-Reply-To: <1322841468-28431-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322841468-28431-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <29404566.LHT7QYyV2R@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Friday 02 of December 2011 15:57:48 Mark Brown wrote:
> Add entries to clocks_off for some additional clocks which are not
> currently used by any mainline drivers. They default on at power up
> but are never actually used so
> 
> If these blocks are actually supported some of these bindings would need
> to be redone properly, for example hooking up to the muxes that use them,
> but that can be done incrementally.

I have already done all the work needed to support the whole range of clocks 
on S3C6410, but I can't find time to create and submit all the patches.

(See: https://github.com/tom3q/spica-3.0/commits/android-
s3c64xx/arch/arm/mach-s3c64xx/clock.c if you are interested.)

Best regards,
Tom
