From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Aug 2012 16:36:03 +0300
Subject: [PATCH v6 11/11] arm: omap: phy: remove unused functions from
 omap-phy-internal.c
In-Reply-To: <1343639400-28725-12-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-12-git-send-email-kishon@ti.com>
Message-ID: <20120803133602.GM8269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 30, 2012 at 02:40:00PM +0530, Kishon Vijay Abraham I wrote:
> All the unnessary functions in omap-phy-internal is removed.
> These functionality are now handled by omap-usb2 phy driver.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Great stuff. I'll take this when we agree on the omap-usb2 phy driver.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/2ff867f0/attachment.sig>
