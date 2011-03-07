From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 7 Mar 2011 10:49:26 +0100
Subject: [patch v3 0/3] arm: pmu: support pmu/perf on OMAP4
In-Reply-To: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
References: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <AANLkTim03rCTHwRANYUpknGvJWuX0ggss3MxP0F=ch0B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tom,

Thanks for those patches, it is really useful to get this code merged in.
Sorry for the late reply, I just sent the comments on the patches.

Thanks,
Jean

On Thu, Mar 3, 2011 at 11:53 AM,  <tom.leiming@gmail.com> wrote:
> Hi,
>
> This patches support pmu irq routed from CTI, such as implemented
> on OMAP4:
>
> ? ? ? ?- introduce some CTI helpers and registers' definition
> ? ? ? ?- introduce .enable_irq and .disable_irq into platform_data,
> ? ? ? ?so perf irq handler can handle irq correctly if it is
> ? ? ? ?routed from CTI on OMAP4
> ? ? ? ?- configure CTI on OMAP4 so that perf can work on OMAP4
>
> The patches have been tested Ok on Pandaboard, and 'perf' does work
> after applying them.
>
> v3:
> ? ? ? ?- fix typo of patch 2/3 title, pointed by Will
> ? ? ? ?- move cti addresses to plat/omap44xx.h, suggested by
> ? ? ? ?Santosh Shilimkar
>
> v2:
> ? ? ? ?- move cti related code out of perf_event.c
> ? ? ? ?- introduce .enable_irq and .disable_irq into platform_data
> ? ? ? ?as suggested by Will.
>
> v1:
> ? ? ? ?- rebase the patch set against 2.6.38-rc6-next-20110301, fix
> ? ? ? ?conflicts, which is pointed out by Will Deacon
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
