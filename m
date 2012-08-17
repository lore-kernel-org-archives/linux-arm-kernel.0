From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Aug 2012 22:55:39 +0100
Subject: [PATCH 00/10 V3] MXS SPI driver
In-Reply-To: <1344007575-11448-1-git-send-email-marex@denx.de>
References: <1344007575-11448-1-git-send-email-marex@denx.de>
Message-ID: <20120817215538.GD18871@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 05:26:05PM +0200, Marek Vasut wrote:
> This patchset adds SPI master support for Freescale i.MX233/i.MX28.
> This is rebased on top of next-20120713. Please consider applying,
> bugs shall now be squashed during the previous two review rounds.

I applied all these except patch 10 (the pinctrl data) which Shawn
wasn't happy with and which seems like it'd make sense to merge via the
arch tree anyway since it's likely to avoid merge conflicts.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/2d4d51e9/attachment.sig>
