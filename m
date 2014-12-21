From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 21 Dec 2014 15:08:26 +0100
Subject: [PATCH v2] clk: rockchip: add CLK_IGNORE_UNUSED flag to fix USB
 Host
In-Reply-To: <1418418352-3947-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1418396066-31360-1-git-send-email-julien.chauveau@neo-technologies.fr>
 <1418418352-3947-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <3524012.TLQ4xTHULn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 12. Dezember 2014, 22:05:52 schrieb Julien CHAUVEAU:
> This patch adds CLK_IGNORE_UNUSED flag to hclk_usb_peri, hclk_usbotg0
> and hclk_usbotg1 because these clocks must remain enabled to use the
> USB controllers in host mode.
> 
> This fixes a regression introduced by commit 78eaf6095cc7
> ("clk: rockchip: disable unused clocks").
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>

applied to my clk/fixes branch with Romain's tags


Heiko
