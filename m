From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 14:49:09 +0000
Subject: [PATCH 0/16] Another round of Device Tree enablement for Snowball
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201204171449.09551.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Lee Jones wrote:
> 
> This patch-set enables the following devices:
>      - External bus for Ethernet chip
>      - SMSC9115 Ethernet chip
>      - DB8500 PRCMU
>      - DB8500 PRCMU Timer (Clocksource)
> 
> ... and provides the following functionality:
>      - Nomadik GPIO controller irqdomain support
> 
> ... and fixes the following bugs:
>      - Attempt to free a non-existent IRQ in SMSC911x
>      - Attempt to probe non-existent devices on Snowball

I found small problems in three patches, everything else

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
