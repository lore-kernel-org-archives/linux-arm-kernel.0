From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 22:28:25 +0000
Subject: [PATCH 2/7] ARM: sunxi: Add pinctrl driver for Allwinner SoCs
In-Reply-To: <1358544639-14761-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
 <1358544639-14761-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201301212228.25770.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 January 2013, Maxime Ripard wrote:
> The Allwinner SoCs have an IP module that handle both the muxing and the
> GPIOs.
> 
> This IP has 8 banks of 32 bits, with a number of pins actually useful
> for each of these banks varying from one to another, and depending on
> the SoC used on the board.
> 
> This driver only implements the pinctrl part, the gpio part will come
> eventually.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
