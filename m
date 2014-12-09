From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 9 Dec 2014 15:13:29 +0100
Subject: [PATCH v4 4/5] ARM: dts: add rk3288 usb PHY
In-Reply-To: <1418093554-30671-1-git-send-email-lyz@rock-chips.com>
References: <1418093554-30671-1-git-send-email-lyz@rock-chips.com>
Message-ID: <CABgxDoJ_anqvD215see84RJ2U04kExyouaN1CNUCTYJ9+XMSig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2014-12-09 3:52 GMT+01:00 Yunzhi Li <lyz@rock-chips.com>:
> This patch adds a device_node for RK3288 SoC usb phy. It also
> defines the phy to be used by three usb controllers: usb_host0/1
> and usb_otg.
>
> Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
>
> ---
>

Tiny thing: Could you change your short description to "ARM: dts:
rockchip: add rk3288 usb PHY" ? (as this is the case for all
devicetree related changes for a specific SoC)

Thanks,
Romain
