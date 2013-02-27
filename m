From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 14:32:30 +0200
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1361968035-18644-4-git-send-email-mkl@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-4-git-send-email-mkl@pengutronix.de>
Message-ID: <20130227123230.GN8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 01:27:09PM +0100, Marc Kleine-Budde wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> This adds two little devicetree helper functions for determining the dr_mode

it looks to me that "mode" is enough. s/dr_mode/mode/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/ba484b41/attachment.sig>
