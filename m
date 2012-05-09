From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 9 May 2012 12:07:15 +0530
Subject: [PATCH 0/3] ARM: OMAP2+: Kconfig: minor cleanup for SOC names
In-Reply-To: <1336514576-4870-1-git-send-email-khilman@ti.com>
References: <1336514576-4870-1-git-send-email-khilman@ti.com>
Message-ID: <CAMQu2gyxWkQq=HnbvWvr95hvFsG0pk2wyMukpSYJU-UnWfo6HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Wed, May 9, 2012 at 3:32 AM, Kevin Hilman <khilman@ti.com> wrote:
> The CONFIG_SOC_* names for do not need an OMAP in the name since
> these are not called OMAP in most places. ?Drop the OMAP in the Kconfig
> names to improve readability.
>
> Also fixes an obvious bug found in the TI81xx code which suggests that
> nobody is using the highest 32 interrupts on these SoCs, or nobody
> is using mainline for TI81xx.
>
> Kevin Hilman (3):
> ?ARM: OMAP2+: INTC: fix Kconfig option for TI81XX
> ?ARM: OMAP2+: Kconfig: convert SOC_OMAPTI81XX to SOC_TI81XX
> ?ARM: OMAP2+: Kconfig: convert SOC_OMAPAM33XX to SOC_AM33XX
>
Any reason linux-omap is not CC'ed on this series ?

Regards
Santosh
