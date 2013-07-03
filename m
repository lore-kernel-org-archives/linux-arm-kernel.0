From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 17:18:46 +0300
Subject: [PATCH v3 5/8] wlcore: add initial device tree support to the
 sdio module
In-Reply-To: <1372860209-3504-6-git-send-email-coelho@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-6-git-send-email-coelho@ti.com>
Message-ID: <20130703141846.GR15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 05:03:26PM +0300, Luciano Coelho wrote:
> If platform data is not available, try to get the required information
> from the device tree.  Register an OF match table and parse the
> appropriate device tree nodes.
> 
> Parse interrupt property only, for now.
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/5ca0ae61/attachment.sig>
