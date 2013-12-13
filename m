From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:23:38 -0600
Subject: [PATCH v6 03/15] usb: phy-mxs: Add auto clock and power setting
In-Reply-To: <1386897825-6130-4-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-4-git-send-email-peter.chen@freescale.com>
Message-ID: <20131213042338.GD867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:23:33AM +0800, Peter Chen wrote:
> With the auto setting, the PHY's clock and power can be
> recovered correctly from low power mode, it is ganranteed by IC logic.

s/ganranteed/guaranteed

Also, I think you need to be slightly more verbose here. Maybe explain a
bit what is the "auto setting". From what I can see from the code, it's
a way to let HW manage clock gating.

Another question, does this feature work in all SoCs where this IP is
available ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/082b1919/attachment.sig>
