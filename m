From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 18 Oct 2010 17:08:53 +0200
Subject: [PATCH 0/7] arm/versatile PCI support, second try
In-Reply-To: <-1220762139438340023@unknownmsgid>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
	<AANLkTikc5Vc0Q0z4rE4raX7LTyB=LiE+YuzycMjsXUaM@mail.gmail.com>
	<-1220762139438340023@unknownmsgid>
Message-ID: <AANLkTi=NhVXqs+_mtUf8LNQWMozOGjaPGmCcVmCZk9CD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/18 Colin Tuckley <colin.tuckley@arm.com>:

> Note that the PB1176 and EB are in mach-realview rather than mach-versatile
> like the PB926. This complicates the PCI side of things since the other
> boards in mach-realview have a different PCI implementation (via a NEC
> custom Northbridge chip).

Aha, then the platform data for these are all wrong... Arnd you'd better
skip the EB and PB1176 platform data patches for now.

Yours,
Linus Walleij
