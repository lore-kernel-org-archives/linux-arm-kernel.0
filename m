From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:25:04 -0600
Subject: [PATCH v6 04/15] usb: doc: phy-mxs: update binding for adding
 anatop phandle
In-Reply-To: <1386897825-6130-5-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-5-git-send-email-peter.chen@freescale.com>
Message-ID: <20131213042504.GE867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:23:34AM +0800, Peter Chen wrote:
> Add anatop phandle which is used to access anatop registers to
> control PHY's power and other USB operations.

no related to this patch, but this feels like OMAP's System Control
Module (a rather simplistic IP which control power for a few other IPs).

We're starting to see a pattern here, eventually we will need a more
generic approach to such types of modules. For now, don't worry :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/3fc68884/attachment.sig>
