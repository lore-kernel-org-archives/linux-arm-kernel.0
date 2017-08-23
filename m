From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 23 Aug 2017 09:26:27 +0200
Subject: [PATCH 0/3] add usb support for rv1108 SoCs
In-Reply-To: <1503304768-14520-1-git-send-email-frank.wang@rock-chips.com>
References: <1503304768-14520-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <4411588.R4EXSA7JtF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 21. August 2017, 16:39:25 CEST schrieb Frank Wang:
> This serie adds USB related device nodes support for rv1108 SoCs, in addition,
> Rockchip's rv1108-evb board has one usb otg controller and one usb host
> controller, each controller connect with one usb-phy port through UTMI+
> interface, the changes also enable usb related for rv1108-evb board.
> 
> Frank Wang (3):
>   dt-bindings: update dt-binding for rv1108 SoCs
>   ARM: dts: rockchip: add usb nodes for rv1108 SoCs
>   ARM: dts: rockchip: enable usb for rv1108-evb

applied all 3 for 4.14 ... with some minor changes to patch subjects
and property ordering


Thanks
Heiko
