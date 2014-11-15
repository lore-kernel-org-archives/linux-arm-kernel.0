From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 16 Nov 2014 00:03:33 +0100
Subject: [PATCH] clk: rockchip: fix clk_usbphy480m_gate bit location in
 register
In-Reply-To: <1415863161-15495-1-git-send-email-kever.yang@rock-chips.com>
References: <1415863161-15495-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1455255.dvOV4oYdNo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. November 2014, 15:19:21 schrieb Kever Yang:
> According to rk3288 trm, the clk_usbphy480m_gate is locate at
> bit 14 of CRU_CLKGATE5_CON register.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

applied this to my clk branch.


Heiko
