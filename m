From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 09:55:10 +0200
Subject: [PATCH v10 6/8] usb: chipidea: imx: add internal vbus regulator
 control
In-Reply-To: <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
Message-ID: <20130227075510.GB8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 27, 2013 at 02:33:17PM +0800, Peter Chen wrote:
> - For host, the vbus should always be on.
> - For otg, the vbus is off defaultly, the vbus needs to be
> turned on/off when usb role switches.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

one quick question, if chipidea already has an imx glue layer, can I
delete the broken imx_udc ? It doesn't even compile and it's including
headers which don't exist.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/c71f99a1/attachment.sig>
