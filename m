From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 15 Jan 2015 19:33:20 +0100
Subject: [PATCH] ARM: SAMSUNG: remove unused DMA infrastructure
In-Reply-To: <2398692.KpvgzHd6no@wuerfel>
References: <2398692.KpvgzHd6no@wuerfel>
Message-ID: <1857858.copsapeGJt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 15. Januar 2015, 16:16:03 schrieb Arnd Bergmann:
> Everything uses dmaengine now, so there is no reason to
> keep this around any longer. Thanks to everyone who was involved
> in moving the users over to use the dmaengine APIs.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

very nice to see this finished :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
