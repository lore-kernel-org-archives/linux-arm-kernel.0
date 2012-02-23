From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Feb 2012 14:30:20 +0200
Subject: [PATCH 4/6] gpio/omap: get rid of retrigger variable in
 gpio_irq_handler
In-Reply-To: <1329999031-6914-5-git-send-email-tarun.kanti@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-5-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120223123019.GH18463@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:40:29PM +0530, Tarun Kanti DebBarma wrote:
> This local variable is just assigned zero and then OR'ed
> with isr. It does not appear to serve any purpose and so
> removing it.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

hehe, makes a lot of sense :-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/a92abce1/attachment.sig>
