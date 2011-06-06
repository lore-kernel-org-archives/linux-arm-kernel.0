From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Jun 2011 22:24:38 +0300
Subject: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
In-Reply-To: <1307386628-1153-2-git-send-email-green@linuxhacker.ru>
References: <1307386628-1153-1-git-send-email-green@linuxhacker.ru>
	<1307386628-1153-2-git-send-email-green@linuxhacker.ru>
Message-ID: <20110606192436.GO12242@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 02:57:07PM -0400, green at linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> to use REGULATOR_SUPPLY arrays.
> 
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Mike Rapoport <mike@compulab.co.il>
> CC: Nishant Kamat <nskamat@ti.com>
> CC: Steve Sakoman <steve@sakoman.com>
> CC: Felipe Balbi <balbi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: peter.barada at logicpd.com
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Acked-by: Felipe Balbi <balbi@ti.com>

I also compile tested with omap2plus_defconfig against 3.0-rc2 and it's
fine.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110606/a07b47a8/attachment.sig>
