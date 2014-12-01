From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 1 Dec 2014 21:26:21 +0100 (CET)
Subject: [PATCH 0/2] rockchip: efuse: add driver to support rk3288 efuse
In-Reply-To: <1417419281-9243-1-git-send-email-jay.xu@rock-chips.com>
References: <1417419281-9243-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <798888970.2970.1417465581078.JavaMail.open-xchange@oxbaltgw06.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jianqun,

> Jianqun Xu <jay.xu@rock-chips.com> hat am 1. Dezember 2014 um 08:34
> geschrieben:
>
>
> In RK3288, there are two eFuse. One is organized as 32bits by 8 one-time
> programmable electrical fuses with random access interface, and the other
> is organized as 32bits by 32 one-time programmable electrical fuses.
>
> Jianqun Xu (2):
> rockchip: efuse: add documentation for rk3288 efuse driver
> rockchip: efuse: add efuse driver for rk3288 efuse
>
> .../bindings/fuse/rockchip,rk3288-efuse.txt | 14 ++
> arch/arm/mach-rockchip/efuse.c | 165 +++++++++++++++++++++
> arch/arm/mach-rockchip/efuse.h | 15 ++

is it possible that you forgot Kconfig and Makefile?

Stefan
