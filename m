From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 00:23:54 +0100
Subject: [GIT PULL] Ux500 device tree changes for v4.5
In-Reply-To: <CACRpkdbts6_Fk-P=Ojom8-OuJ+UThA54fXB_eTcq0H7imUBhsg@mail.gmail.com>
References: <CACRpkdbts6_Fk-P=Ojom8-OuJ+UThA54fXB_eTcq0H7imUBhsg@mail.gmail.com>
Message-ID: <3557880.PPEK4EKzvb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 14:55:29 Linus Walleij wrote:
> Device Tree changes for Ux500:
> - Push the Rohm touchscreen to the STUIB, as the TVK UIB has
>   a Synaptics RMI4 touchscreen.
> - Set up the right sensor IRQs for the Snowball, so that
>   periodic data ready-IRQ capture starts working.
> - Use wakeup-source consequently.
> - Remove legacy regulator-compatible strings.
> - Define the sensors on the HREFP TVK board properly.
> 

Pulled into next/dt, thanks!

	Arnd
