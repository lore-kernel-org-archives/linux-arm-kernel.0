From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 17:15:57 +0000
Subject: [PATCH 13/16] ARM: omap: move platform_data definitions
In-Reply-To: <CAN5iSWqnyA0VNDkaCb7bcZOhQxOxJ8xUy4RXWgt+xukSUmHnAA@mail.gmail.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-13-git-send-email-arnd@arndb.de>
 <CAN5iSWqnyA0VNDkaCb7bcZOhQxOxJ8xUy4RXWgt+xukSUmHnAA@mail.gmail.com>
Message-ID: <201209121715.58621.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012, Pihet-XID, Jean wrote:
> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/include/linux/platform_data/smartreflex-omap.h
> > similarity index 100%
> > rename from arch/arm/plat-omap/include/plat/voltage.h
> > rename to include/linux/platform_data/smartreflex-omap.h
> The filename should be voltage-omap.h. The header file is for a
> voltage layer which is used by other layers, one of them is the
> smartreflex driver code (in drivers/power/avs).
> The header file for the smartreflex driver is in
> include/linux/power/smartreflex.h.

Ok, makes sense. Changed now.

	Arnd
