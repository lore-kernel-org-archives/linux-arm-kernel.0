From: colin.tuckley@arm.com (Colin Tuckley)
Date: Mon, 18 Oct 2010 09:54:43 +0100
Subject: [PATCH 0/7] arm/versatile PCI support, second try
In-Reply-To: <AANLkTikc5Vc0Q0z4rE4raX7LTyB=LiE+YuzycMjsXUaM@mail.gmail.com>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
	<AANLkTikc5Vc0Q0z4rE4raX7LTyB=LiE+YuzycMjsXUaM@mail.gmail.com>
Message-ID: <000001cb6ea2$1b78ccd0$526a6670$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij
> Sent: 16 October 2010 21:53

> > With lots of help and testing from Peter Maydell, I've completed
> > a second version of the PCI support for the versatile platform,
> > which works much better now on real hardware, although it does
> > not improve existing qemu setups.
> 
> I've got nothing better to do tonite than playing with the PB1176
> board so tried this out...

Note that the PB1176 and EB are in mach-realview rather than mach-versatile
like the PB926. This complicates the PCI side of things since the other
boards in mach-realview have a different PCI implementation (via a NEC
custom Northbridge chip).

I am just about to push the PCI code patches for these boards (PBA8,
PB11MPCore and PBX) to the list.

Regards,

Colin
