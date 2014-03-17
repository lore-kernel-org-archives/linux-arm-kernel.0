From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 15:47:45 +0100
Subject: [GIT PULL] at91: cleanup for 3.15 #1
In-Reply-To: <1394647325-29757-1-git-send-email-nicolas.ferre@atmel.com>
References: <1394647325-29757-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201403171547.45327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the first AT91 pull-request for 3.15, and a cleanup one. The most of it
> is the conversion of two more Atmel SoCs to Device Tree. These are older that
> the ones already converted. Moreover, they already use the CCF so there is no
> need to come back on this later (maybe to remove some code when the other
> non-DT boards are converted as well).
> The defconfig update was needed because they were pretty old and some
> interesting options were missing.

Pulled into next/cleanup, thanks!

	Arnd
