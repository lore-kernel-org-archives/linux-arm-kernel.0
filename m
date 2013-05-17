From: balbi@ti.com (Felipe Balbi)
Date: Fri, 17 May 2013 23:05:31 +0300
Subject: [PATCH 6/6] ARM: OMAP2+: Remove omap4 ocp2scp pdata
In-Reply-To: <20130517191803.468.32800.stgit@localhost>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191803.468.32800.stgit@localhost>
Message-ID: <20130517200531.GA17851@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 12:18:03PM -0700, Tony Lindgren wrote:
> This is omap4+ only and no longer needed as omap4+ can be booted
> using device tree.
> 
> Also remove the related pdata handling from the driver and the
> now unneeded platform_data/omap_ocp2scp.h.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

fine by me :-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130517/b9180ad0/attachment.sig>
