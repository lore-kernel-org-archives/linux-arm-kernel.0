From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 26 Jan 2016 01:13:39 +0100
Subject: [PATCH 0/3] Add rk3066 tsadc device tree bindings
In-Reply-To: <1453205361-27267-1-git-send-email-paweljarosz3691@gmail.com>
References: <1453205361-27267-1-git-send-email-paweljarosz3691@gmail.com>
Message-ID: <4176431.EN0Q2CUI1l@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 19. Januar 2016, 13:09:18 schrieb Pawe? Jarosz:
> This patchset adds devicetree bindings for rockchip rk3066 tsadc with needed
> dependencies.
> 
> Pawe? Jarosz (3):
>   clk: rockchip: Add new id for rk3066 tsadc clock
>   clk: rockchip: add tsadc clock on rk3066
>   ARM: dts: rockchip: add tsadc node

applied all three to appropriate branches for 4.6

I've removed the vref-supply from the dtsi and moved some properties around a 
bit.


Heiko
