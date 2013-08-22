From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 11:57:27 -0700
Subject: [GIT PULL 1/2] DaVinci SoC updates for v3.12
In-Reply-To: <52151BA6.2060109@ti.com> (Sekhar Nori's message of "Thu, 22 Aug
 2013 01:27:26 +0530")
References: <52151BA6.2060109@ti.com>
Message-ID: <87ppt5r1t4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> Hi Arnd, Olof, Kevin,
>
> Please pull the following DaVinci SoC changes for v3.12
>
> Thanks,
> Sekhar
>
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.12/soc
>
> for you to fetch changes up to 46c1833467c5e555f31cd6f14b342a7383f26885:
>
>   ARM: davinci: fix clock lookup for mdio device (2013-08-22 00:39:01 +0530)
>
> ----------------------------------------------------------------
> DaVinci SoC updates for v3.12
> -----------------------------
>
> This set of SoC updates contains changes to the
> way UART clock is handled to enabled DT-boot to
> obtain UART clock frequency instead of relying
> on DT-binding being supplied. Similarly handling
> of MDIO clock is fixed to make it easier to support
> MDIO in DT-boot. Finally there is patch to remove
> now unnecessary setting of wake-up capable flag for
> RTC.

Thanks for the detailed description.

Pulled into next/soc

Kevin
