From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 19 Oct 2009 22:32:47 +0200
Subject: [PATCH v2 1/2] arm: a driver for on-chip ETM and ETB
In-Reply-To: <71a0d6ff0910190557q25cb1da2o1bcd6bdd5348c881@mail.gmail.com>
References: <1255453611-16119-1-git-send-email-virtuoso@slind.org>
	<20091013174413.GA1134@n2100.arm.linux.org.uk>
	<71a0d6ff0910190557q25cb1da2o1bcd6bdd5348c881@mail.gmail.com>
Message-ID: <63386a3d0910191332y7162d4c4vec625bcda24a8dcb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/19 Alexander Shishkin <virtuoso@slind.org>:

> That said, I'm personally not overly concerned about the support for
> earlier versions of those macrocells and if you maintain that those
> are better off implemented as AMBA drivers, I've not problem doing
> that.

If people are using older versions, they can hardcode the peripheral
ID when they define the AMBA device in their board setup. This
effectively deactivates the probe for device ID:s.

So it's safe to use the AMBA PrimeCell abstraction anyway.

Linus Walleij
