From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 2 May 2011 22:12:10 +0200
Subject: AT91: PMC definitions are plaform-depenent
In-Reply-To: <20110502193246.GL1212@game.jcrosoft.org>
References: <1304352989.17141.9.camel@redbox>
	<20110502193246.GL1212@game.jcrosoft.org>
Message-ID: <BANLkTimZ4mPoRX5DMH8g1skwbP2BiwJ34Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Jean-Christophe,

> no need the PMC is at the same address on all soc

That just happens to be the case with the currently-released ARM9-based AT91's.
You just need to look at the base-addresses of the other
system-peripherals to see there is not much consistency.

So I don't want to design a system that will break (or that we have to
hack around) if/when Atmel releases a new processor where the PMC is
at a different address.


Regards,
  Andrew Victor
