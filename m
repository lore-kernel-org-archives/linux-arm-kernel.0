From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Aug 2018 12:31:21 +0200
Subject: [PATCH 1/4] phy: rockchip-inno-usb2: fix misspelling and
 kernel-doc documentation.
In-Reply-To: <20180815095934.11205-2-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-2-enric.balletbo@collabora.com>
Message-ID: <2908229.jFki8unlfB@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. August 2018, 11:59:31 CEST schrieb Enric Balletbo i Serra:
> Fix the typo flase -> false and clean up the kernel-doc documentation in
> phy-rockchip-inno.usb2.c and fix the following warnings when documentation
> is built.
> 
>   :58: warning: missing initial short description
>   :69: warning: cannot understand function prototype: 'enum usb_chg_state '
>   :97: warning: missing initial short description
>   :136: warning: cannot understand function prototype: 'struct rockchip_usb2phy_port_cfg '
>   :157: warning: cannot understand function prototype: 'struct rockchip_usb2phy_cfg '
>   :163: warning: Function parameter or member 'port_cfgs' not described in 'rockchip_usb2phy_cfg'
>   :187: warning: cannot understand function prototype: 'struct rockchip_usb2phy_port '
>   :204: warning: Function parameter or member 'port_cfg' not described in 'rockchip_usb2phy_port'
>   :207: warning: missing initial short description
>   :234: warning: Function parameter or member 'dev' not described in 'rockchip_usb2phy'
>   :234: warning: Function parameter or member 'clk480m_hw' not described in 'rockchip_usb2phy'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
