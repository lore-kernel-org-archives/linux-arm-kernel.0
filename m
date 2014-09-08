From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 22:41:17 +0200
Subject: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets'
 properties
In-Reply-To: <540E12A3.2080705@openwrt.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
 <3479071.8nx1ubr8a9@wuerfel> <540E12A3.2080705@openwrt.org>
Message-ID: <7211807.u2YLVoXUf1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 13:33:39 Florian Fainelli wrote:
> So what we are missing right now is just a 'cache-line-size' property to
> get the maths right.

Patch 6/7 actually adds that already, and it's even required by ePAPR.

	Arnd
