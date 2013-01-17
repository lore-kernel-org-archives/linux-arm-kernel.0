From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 13:48:38 +0200
Subject: [PATCH v7 18/22] USB: ehci-omap: Don't free gpios that we didn't
 request
In-Reply-To: <1358422231-24736-19-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-19-git-send-email-rogerq@ti.com>
Message-ID: <20130117114838.GH18978@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 01:30:27PM +0200, Roger Quadros wrote:
> This driver does not request any gpios so don't free them.
> Fixes L3 bus error on multiple modprobe/rmmod of ehci_hcd
> with ehci-omap in use.
> 
> CC: Alan Stern <stern@rowland.harvard.edu>
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

should this go to stable ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/8b52f64b/attachment.sig>
