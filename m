From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 10:15:21 +0200
Subject: [RESEND PATCH v9 0/2] usb: phy: samsung: Introducing usb phy
 driver for samsung SoCs
In-Reply-To: <1358499623-13901-1-git-send-email-p.paneri@samsung.com>
References: <1358499623-13901-1-git-send-email-p.paneri@samsung.com>
Message-ID: <20130227081521.GG8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 18, 2013 at 02:30:21PM +0530, Praveen Paneri wrote:
> Changes from v8:
> Resending this patch series after rebasing to the latest usb-next branch.
> Rewording inline comments for better readability.
> Removed IS_ENABLED(CONFIG_OF) as pdev->dev.of_node is enough to check for dt support.
> Using of_match_ptr to add of_match_table to platform_driver structure.
> Removed unnecessary variables.

trying applying these but it doesn't apply unfortunately.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/497c9e86/attachment.sig>
