From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 20:29:31 +0200
Subject: [GIT PULL 1/3] ARM: bcm2835: device tree updates
In-Reply-To: <1365125338-6668-1-git-send-email-swarren@wwwdotorg.org>
References: <1365125338-6668-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304082029.32051.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> This branch adds two devices to the BCM2835 SoC device tree: the SPI
> controller and the HW random number generator.
> 
> The SPI controller isn't actually instantiated in the Raspberry Pi
> device tree, since there are no on-board SPI devices; it's up to the
> end-user to modify their own device-tree to describe whatever they
> have attached.
> 

Pulled all three branches, thanks!

	Arnd
