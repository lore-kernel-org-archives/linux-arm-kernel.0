From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 5 Aug 2010 09:27:51 +0200
Subject: [PATCH 4/5] arm/realview: enable PCI for realview-eb and
	realview-pb1176
In-Reply-To: <1280942692-32079-5-git-send-email-arnd@arndb.de>
References: <1280942692-32079-1-git-send-email-arnd@arndb.de>
	<1280942692-32079-5-git-send-email-arnd@arndb.de>
Message-ID: <AANLkTin2O1pKjP=QwR8WeFAyy1iVDrtUjpsLYdcCS+F_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/4 Arnd Bergmann <arnd@arndb.de>:

> These two boards use the Xilinx PCI macro, so enable the
> code and set up all the I/O windows for it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Cool, having worked on the PB1176 recently I think I can say:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
