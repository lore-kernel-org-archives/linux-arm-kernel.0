From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 1 Jul 2018 09:54:39 +0200
Subject: [PATCH net-next 2/5] net: gemini: Improve connection prints
In-Reply-To: <20180630161806.24312-2-linus.walleij@linaro.org>
References: <20180630161806.24312-1-linus.walleij@linaro.org>
 <20180630161806.24312-2-linus.walleij@linaro.org>
Message-ID: <20180701075439.GA15006@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 30, 2018 at 06:18:03PM +0200, Linus Walleij wrote:
> Instead of just specify that a PHY is connected at some
> speed, also specify which one. This is helpful with several
> PHYs on the system.

Hi Linus

Could you just use phy_print_status()

      Andrew
