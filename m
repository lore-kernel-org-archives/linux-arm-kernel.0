From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 17:11:10 +0300
Subject: [PATCH v3 1/8] wl1251: split wl251 platform data to a separate
 structure
In-Reply-To: <1372860209-3504-2-git-send-email-coelho@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-2-git-send-email-coelho@ti.com>
Message-ID: <20130703141110.GN15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 05:03:22PM +0300, Luciano Coelho wrote:
> Move the wl1251 part of the wl12xx platform data structure into a new
> structure specifically for wl1251.  Change the platform data built-in
> block and board files accordingly.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/6b8a1695/attachment-0001.sig>
