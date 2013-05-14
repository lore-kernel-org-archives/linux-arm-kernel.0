From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 May 2013 22:23:37 +0200
Subject: [PATCH] ASoC: remove saarb and tavorevb3 machine drivers
In-Reply-To: <1368544041.1350.111.camel@x61.thuisdomein>
References: <1368544041.1350.111.camel@x61.thuisdomein>
Message-ID: <2843869.zn4rrxyCrZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 May 2013 17:07:21 Paul Bolle wrote:
> Support for PXA95x was removed in v3.8. This means that the Kconfig
> symbols MACH_SAARB and MACH_TAVOREVB3 are no longer available. This
> leaves the SoC Audio support for Marvell Saarb and Marvell Tavor EVB3
> unbuildable. Remove these drivers too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Arnd Bergmann <arnd@arndb.de>
