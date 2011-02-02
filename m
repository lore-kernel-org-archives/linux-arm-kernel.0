From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Feb 2011 18:31:58 +0000
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <1296667999.1504.44.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
	<1296653211.1504.40.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEFD45C8@AUSP01VMBX24.collaborationhost.net>
	<20110202165959.GT12743@opensource.wolfsonmicro.com>
	<1296667999.1504.44.camel@r60e>
Message-ID: <20110202183158.GG9810@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 08:33:19PM +0300, Alexander Sverdlin wrote:

> It's a chip select. The way I've managed it in CODEC it's because Cirrus
> boards do not have any other SPI devices. Supported by current mainline,
> at least.

Please do this properly with the SPI core.
