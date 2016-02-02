From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 02 Feb 2016 09:16:48 +0100
Subject: [PATCH v2 2/2] arm/mach-imx: enable big endian mode
In-Reply-To: <20160202053304.GA8307@tiger>
References: <1453913976-30619-1-git-send-email-johannes@sipsolutions.net>
 <1453913976-30619-3-git-send-email-johannes@sipsolutions.net>
 <20160202053304.GA8307@tiger>
Message-ID: <1454401008.2926.0.camel@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-02-02 at 13:33 +0800, Shawn Guo wrote:
>?
> We conventionally use "ARM: imx: ..." as the subject for IMX platform
> patches.

Fair enough. I thought I saw this style used in the git log, but I may
very well be mistaken :)

> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -9,6 +9,7 @@ menuconfig ARCH_MXC
> > ?	select PM_OPP if PM
> > ?	select SOC_BUS
> > ?	select SRAM
> > +	select ARCH_SUPPORTS_BIG_ENDIAN
> 
> It should be added in alphabetical order.

Heh, ok.

> I fixed these two minor things and applied both patches.

Great, thanks!

johannes
