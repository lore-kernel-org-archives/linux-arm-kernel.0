From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Oct 2016 11:20:41 +0200
Subject: [PATCH] arm64: defconfig: enable EEPROM_AT25 config option
In-Reply-To: <a61b2b9d-356f-f24b-914b-0fb0e2bcdcc6@gmail.com>
References: <1475875432-13627-1-git-send-email-scott.branden@broadcom.com>
 <a61b2b9d-356f-f24b-914b-0fb0e2bcdcc6@gmail.com>
Message-ID: <1503155.onL8VV3RJv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 10, 2016 2:08:05 AM CEST Florian Fainelli wrote:
> On 10/07/2016 02:23 PM, Scott Branden wrote:
> > Enable support for on board SPI EEPROM by turning on
> > CONFIG_EEPROM_AT25.
> > 
> > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> Looks fine to me, unless this needs to be a module, Arnd, what do you think?

Please either make it a module or explain in the patch description
why it should be built-in.

	Arnd
