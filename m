From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 17 Jul 2017 09:09:18 +0200
Subject: [PATCH 0/2] mmc: omap: Remove Unused Code
In-Reply-To: <20170717060101.GB10026@atomide.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
 <20170717060101.GB10026@atomide.com>
Message-ID: <CAPDyKFqk1fnL_CFSfgg2P44-KD9H=6mvK6ppXoDe=Xy38ujiFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2017 at 08:01, Tony Lindgren <tony@atomide.com> wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [170714 05:48]:
>> This patch series removes some code in omap_hsmmc.c
>> and hsmmc.c and members from hsmmc.h and
>> hsmmc-omap.h which are not used anymore post
>> conversion to device-tree.
>
> Hey that's nice! That gets us a bit closer removing the
> old platform data for that driver.

Tony,

As it seems Kishon is working on some more omap_hsmmc changes, I
wondering whether it's fine if I pick this series via my mmc tree. To
avoid merge conflicts later on?

Kind regards
Uffe
