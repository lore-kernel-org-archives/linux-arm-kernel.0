From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 17:16:59 +0300
Subject: [PATCH v3 4/8] wl12xx: use frequency instead of enumerations for
 pdata clocks
In-Reply-To: <1372860209-3504-5-git-send-email-coelho@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-5-git-send-email-coelho@ti.com>
Message-ID: <20130703141659.GQ15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 05:03:25PM +0300, Luciano Coelho wrote:
> Instead of defining an enumeration with the FW specific values for the
> different clock rates, use the actual frequency instead.  Also add a
> boolean to specify whether the clock is XTAL or not.
> 
> Change all board files to reflect this.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/bc1df054/attachment-0001.sig>
