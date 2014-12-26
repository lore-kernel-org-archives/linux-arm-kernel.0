From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Dec 2014 13:33:28 -0600
Subject: [PATCH 3/5] input: misc: add tps65218 power button driver
In-Reply-To: <1419622104-25812-4-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-4-git-send-email-balbi@ti.com>
Message-ID: <20141226193327.GK17430@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 26, 2014 at 01:28:22PM -0600, Felipe Balbi wrote:
> +static struct of_device_id of_tps65218_pwr_match[] = {
> +	{ .compatible = "ti,tps65218-pwrbutton" },

forgot to document this compatible. I'll add it localy but still wait a
a few days before resending so people have time to review.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141226/0d6d889b/attachment.sig>
