From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 21:19:11 +0200
Subject: [PATCH 6/9] ARM: dts: rockchip: Add usb host for rk3288-vyasa
In-Reply-To: <1508156187-27519-7-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
 <1508156187-27519-7-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1761916.pIAoj0xHaJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 16. Oktober 2017, 17:46:24 CEST schrieb Jagan Teki:
> Add usb host support for rk3288-vyasa, board support hub power
> through phy_pwr_en and usb2 host power through usb2_pwr_en and
> naming conversion followed as per schematic.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

applied for 4.15, after dropping the RK_GPIO8 addition and making
the pin use "8" directly instead of the outdated constant.

It isn't planned to extend this GPIOx -> x ... instead it is more or
less deprecated.
