From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Jun 2013 13:21:00 +0200
Subject: [PATCHv2 1/3] net: phy: prevent linking breakage
In-Reply-To: <51AF03AF.3080106@free-electrons.com>
References: <1369741403-25315-2-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGVrzcZcVB5+NqLop+ALrX4Jx_SyNatczLt4oNzXr7bjgKMXhg@mail.gmail.com>
 <51AF03AF.3080106@free-electrons.com>
Message-ID: <201306051321.00264.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013, Alexandre Belloni wrote:
> However, it is becoming urgent for Atmel to get the fix in 3.10 so that
> they never get a kernel compilation that breaks.

I don't think it's urgent since this is only about rare configurations,
and not a regression. We can queue the patch "ARM: at91: Fix link
breakage when !CONFIG_PHYLIB" you just sent to fix this, but I
would not consider it a serious problem to have it only in 3.11.

	Arnd
