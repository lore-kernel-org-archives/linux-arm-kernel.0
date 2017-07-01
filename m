From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 01 Jul 2017 21:26:18 +0200
Subject: [PATCH 0/5] some devicetree changes for rk3288 boards
In-Reply-To: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
References: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <10271838.b6AgH4ZSYx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 1. Juli 2017, 10:02:42 CEST schrieb Jacob Chen:
> Since Guillaume have send patches for mali gpu node, let's enable it in more boards.
> 
> Jacob Chen (5):
>   ARM: dts: rockchip: enable ARM Mali GPU on rk3288-tinker
>   ARM: dts: rockchip: enable ARM Mali GPU on rk3288-evb
>   ARM: dts: rockchip: enable ARM Mali GPU on rk3288-fennec
>   ARM: dts: rockchip: enable saradc for rk3288-evb
>   ARM: dts: rockchip: enable adc key for rk3288-evb

applied for 4.14, with the saradc patch replaced with your v2


Heiko
