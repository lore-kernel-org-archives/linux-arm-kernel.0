From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Feb 2012 14:29:43 +0200
Subject: [PATCH 3/6] gpio/omap: remove suspend_wakeup field from struct
 gpio_bank
In-Reply-To: <1329999031-6914-4-git-send-email-tarun.kanti@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-4-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120223122942.GG18463@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:40:28PM +0530, Tarun Kanti DebBarma wrote:
> Since we already have bank->context.wake_en to keep track
> of gpios which are wakeup enabled, there is no need to have
> this field any more.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/7a3c8f2e/attachment.sig>
