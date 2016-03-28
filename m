From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Mar 2016 14:59:59 +0200
Subject: [PATCH v6 0/3] Add more clock compatible features and support the
 RK3399 clock
In-Reply-To: <1459158697-8218-1-git-send-email-zhengxing@rock-chips.com>
References: <1459158697-8218-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <4649399.g7v7zsVJik@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 28. M?rz 2016, 17:51:34 schrieb Xing Zheng:
>   The patch series add support more mux parameters and multiple
> clock providers for the rockchip features of the clock framework,
> and support the clock controller for the RK3399.

applied all 3 for 4.7 with one change:

I've dropped the grf paragraph from the binding doc (as it is not used 
anymore) and also dropped the gmac_phy_rx_clk input clock.

We can add these back once they are getting used in the future.


Heiko
