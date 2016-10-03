From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Oct 2016 22:19:17 -0700
Subject: [PATCH] arm64: Enable HIBERNATION in defconfig
In-Reply-To: <20160915100231.GG2492@e104818-lin.cambridge.arm.com>
References: <1473932534-2710-1-git-send-email-catalin.marinas@arm.com>
 <20160915100231.GG2492@e104818-lin.cambridge.arm.com>
Message-ID: <20161003051917.GC4403@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 15, 2016 at 11:02:31AM +0100, Catalin Marinas wrote:
> On Thu, Sep 15, 2016 at 10:42:14AM +0100, Catalin Marinas wrote:
> > This patch adds CONFIG_HIBERNATION to the arm64 defconfig.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index eadf4855ad2d..91a7592029e3 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -80,6 +80,7 @@ CONFIG_KEXEC=y
> >  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> >  CONFIG_COMPAT=y
> >  CONFIG_CPU_IDLE=y
> > +CONFIG_HIBERNATION=y
> >  CONFIG_ARM_CPUIDLE=y
> >  CONFIG_CPU_FREQ=y
> >  CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
> 
> Or maybe it could go through arm-soc as it seems Arnd has picked up a
> few other defconfig patches.

When we just get a cc of a reply to a patch, it's usually pretty error prone
whether we end up applying it. Which happened here, I just came across this
when making a final sweep.

Yes, in general we tend to have more changes to the defconfig, so it's
appreciated to get these sent our way.

Given timing, resend after -rc1? We should be OK with applying it for 4.9
still around that time.


-Olof
