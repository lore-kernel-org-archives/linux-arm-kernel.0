From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Feb 2012 14:28:15 +0200
Subject: [PATCH 1/6] gpio/omap: remove saved_fallingdetect,
 saved_risingdetect fields
In-Reply-To: <1329999031-6914-2-git-send-email-tarun.kanti@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-2-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120223122814.GE18463@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:40:26PM +0530, Tarun Kanti DebBarma wrote:
> Since we already have context.fallingdetect and context.risingdetect
> there is no more need to have these additional fields. Also, getting
> rid of extra reads associated with them.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Looks trivial and correct:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/31bfab51/attachment.sig>
