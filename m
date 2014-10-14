From: balbi@ti.com (Felipe Balbi)
Date: Tue, 14 Oct 2014 13:34:26 -0500
Subject: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing
 MODULE_ALIAS()
In-Reply-To: <1413311335-25083-2-git-send-email-balbi@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-2-git-send-email-balbi@ti.com>
Message-ID: <20141014183426.GA19491@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 01:28:54PM -0500, Felipe Balbi wrote:
> without MODULE_ALIAS(), omapfb won't get loaded
> automatically.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

little note here. This makes omapfb load automatically, but display
still doesn't work with DSS as modules. Backlight is working and pixel
clock is running just fine. Still, nothing on display.

I thought I'd leave that for Tomi to deal with.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141014/59786856/attachment.sig>
