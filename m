From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Feb 2011 10:49:43 +0000
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <1296643688.1504.23.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
Message-ID: <20110202104943.GN12743@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 01:48:08PM +0300, Alexander Sverdlin wrote:

> I'm really confused now, where should it be? If I will init
> cs4271_platform_data with GPIO values, CODEC driver will manage it.
> Otherwise CODEC driver should be rewritten without GPIO support and I
> can add it to platform code.

What is the problem?
