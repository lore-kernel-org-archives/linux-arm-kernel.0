From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jul 2012 22:19:40 +0000
Subject: [GIT PULL] ARM: LPC32xx: Core updates
In-Reply-To: <50094A0E.4070006@antcom.de>
References: <50094A0E.4070006@antcom.de>
Message-ID: <201207202219.40319.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 July 2012, Roland Stigge wrote:
> Hi Arnd and Olof,
> 
> this LPC32xx core update (branch lpc32xx/core2) builds upon the
> previously provided lpc32xx/core-fixes. Basically including PWM support
> (for the PWM driver from Alexandre already in the pwm tree), and
> CPU ID.

Pulled both branches into the sames ones as earlier respective ones.
Note that you don't actually have to start a new branch when you
add patches for the same topic, you can just add stuff on top,
whichever works best for you.

It would be nice if you can start sending tags rather than branches,
because that lets you put the changeset text right into the tag
so I don't have to copy it into the merge text manually.

	Arnd
