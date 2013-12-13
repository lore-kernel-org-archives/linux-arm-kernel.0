From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:38:38 -0600
Subject: [PATCH v6 14/15] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <1386897825-6130-15-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-15-git-send-email-peter.chen@freescale.com>
Message-ID: <20131213043838.GI867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:23:44AM +0800, Peter Chen wrote:
> +SIMPLE_DEV_PM_OPS(mxs_phy_pm, mxs_phy_system_suspend, mxs_phy_system_resume);

should be static.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/ce24a0d4/attachment.sig>
