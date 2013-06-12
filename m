From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 13:26:56 +0200
Subject: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
In-Reply-To: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <3315236.ZNXhyxmCRd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013 10:07:09 Maxime Ripard wrote:
> 
> This patchset adds support for the I2C controller found on most of the
> Allwinner SoCs, especially the already supported A10 and A13, and the
> yet to come A31.
> 
> This driver leverages the Marvel mv64xxx i2c controller driver, that has
> an almost identical logic, with a slightly different register layout.
> 
> It has been tested on a A13-Olinuxino and an A10s-Olinuxino.

It doesn't really matter, but can someone clarify why this driver can
be reused? Did marvell and allwinner license the same hardware block
or is just a really simple driver that does things in an obvious way?

	Arnd
