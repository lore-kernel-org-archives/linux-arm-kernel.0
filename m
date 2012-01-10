From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 10 Jan 2012 10:49:00 +0200
Subject: [PATCH v4] MTD/GPMI bugfix : reset the BCH module when it is
 not MX23
In-Reply-To: <1325647126-4281-1-git-send-email-b32955@freescale.com>
References: <1325647126-4281-1-git-send-email-b32955@freescale.com>
Message-ID: <1326185340.8847.11.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-01-04 at 11:18 +0800, Huang Shijie wrote:
> In MX28, if we do not reset the BCH module. The BCH module may
> becomes unstable when the board reboots for several thousands times.
> This bug has been catched in customer's production.
> 
> The patch adds some comments(some from Wolfram Sang), and fixes it now.
> 
> Also change gpmi_reset_block() to static.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120110/2dba91fd/attachment.sig>
