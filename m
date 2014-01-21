From: sre@debian.org (Sebastian Reichel)
Date: Tue, 21 Jan 2014 16:26:05 +0100
Subject: [PATCHv3 30/41] ARM: omap3-n900.dts: add display information
In-Reply-To: <1390301833-24944-31-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-31-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20140121152605.GA5983@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 12:57:02PM +0200, Tomi Valkeinen wrote:
> Add DT data for OMAP3 N900 board. The board has the following
> displays:
> 
> lcd: LCD panel connected to OMAP's SDI output
> tv: analog svideo
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Your dss-dt-review-3 branch boots on my N900 with working display.

Tested-by: Sebastian Reichel <sre@debian.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140121/7ad69e80/attachment.sig>
