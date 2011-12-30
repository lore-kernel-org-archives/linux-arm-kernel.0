From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 30 Dec 2011 15:36:58 +0100
Subject: [PATCH v2] MTD/GPMI bugfix : reset the BCH module when it is not
 MX23
In-Reply-To: <1325233646-3343-1-git-send-email-b32955@freescale.com>
References: <1325233646-3343-1-git-send-email-b32955@freescale.com>
Message-ID: <20111230143658.GA9141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 04:27:26PM +0800, Huang Shijie wrote:
> In MX28, if we do not reset the BCH module. The BCH module may
> becomes unstable when the board reboots for several thousands times.

Do you have more details when and why this happens? What happens on MX23 then?

> Signed-off-by: Huang Shijie <b32955@freescale.com>

Is this Bug 2847 from the errata? Should be mentioned in the commit message and
comments of the patch if so.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111230/424847b3/attachment.sig>
