From: balbi@ti.com (Felipe Balbi)
Date: Mon, 26 Nov 2012 11:52:34 +0200
Subject: [PATCHv2] i2c: omap: Remove the
 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE flag
In-Reply-To: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
References: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121126095234.GA16256@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 26, 2012 at 03:25:11PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
> in the i2c driver. Remove the flag.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

looks ok to me:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/96f2bb07/attachment.sig>
