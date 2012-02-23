From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Feb 2012 14:28:46 +0200
Subject: [PATCH 2/6] gpio/omap: remove saved_wakeup field from struct
 gpio_bank
In-Reply-To: <1329999031-6914-3-git-send-email-tarun.kanti@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120223122846.GF18463@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:40:27PM +0530, Tarun Kanti DebBarma wrote:
> There is no more need to have saved_wakeup. Instead we can use
> context.wake_en which holds the current wakeup enable register
> context. This also means that the read from wakeup enable register
> is not needed.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Likewise:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/419cb932/attachment.sig>
