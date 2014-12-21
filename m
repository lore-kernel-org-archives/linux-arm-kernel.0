From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 21 Dec 2014 15:26:22 +0100
Subject: [PATCH] clk: rockchip: Fix clock gate for rk3188 hclk_emem_peri
In-Reply-To: <1418406639-13668-1-git-send-email-romain.perier@gmail.com>
References: <1418406639-13668-1-git-send-email-romain.perier@gmail.com>
Message-ID: <202741351.urIaKyAj2C@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 12. Dezember 2014, 17:50:39 schrieb Romain Perier:
> Do not disable clock gate "hclk_emem_peri", otherwise EMAC clocks no longer
> work and it breaks ethernet on RK3066 and RK3188. It fixes a regression
> introduced by commit 78eaf6095cc763c1a228ebac5682852f04e85205 ("clk:
> rockchip: disable unused clocks").
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

applied to my clk fixes branch for 3.19


Heiko
