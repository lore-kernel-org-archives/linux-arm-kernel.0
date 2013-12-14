From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Dec 2013 20:06:26 +0100
Subject: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
In-Reply-To: <1386901645-28895-4-git-send-email-ynvich@gmail.com>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-4-git-send-email-ynvich@gmail.com>
Message-ID: <201312142006.26979.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 December 2013, Sergei Ianovich wrote:
> Non-dts implementation supply required DMA channel numbers as
> IORESOURCE_DMA. However, there is was no way to get them from
> device tree.

Please update this changeset comment, I think it still refers to
the earlier version.
 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Daniel Mack <zonque@gmail.com>
> CC: Arnd Bergmann <arnd@arndb.de>

The patch looks ok in case we are merging your patches for 3.14
and Daniel's patches later than that. If they end up in the
same merge window however, we'd have to be care to resolve
the obvious conflict in a proper way.

	Arnd
