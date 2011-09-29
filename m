From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Thu, 29 Sep 2011 20:15:54 +0530
Subject: [PATCH 0/2] arm: omap4: hsmmc: pbias fixes
In-Reply-To: <4e848386.2a1f440a.4d36.1824SMTPIN_ADDED@mx.google.com>
References: <4e848386.2a1f440a.4d36.1824SMTPIN_ADDED@mx.google.com>
Message-ID: <CANrkHUbSRLZe+6QWOSE0Hz6r5NUkRxUH+RW2_CYiQ3wrWu-Pzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Balaji T K <balajitk@ti.com>
Will resend this series as my email id is garbled.

>
> MMC1 pbias and speed control fix for SDMMC1 extended I/O cell
>
> Balaji T K (2):
> ?arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
> ?arm: omap4: hsmmc: configure SDMMC1_DR0 properly
>
> ?arch/arm/mach-omap2/hsmmc.c | ? 16 +++-------------
> ?1 files changed, 3 insertions(+), 13 deletions(-)
>
>
