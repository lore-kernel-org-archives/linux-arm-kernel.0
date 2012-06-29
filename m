From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 29 Jun 2012 14:46:09 +0300
Subject: [PATCH v2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <1338279369-25915-1-git-send-email-s.hauer@pengutronix.de>
References: <1338279369-25915-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1340970369.3070.166.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-29 at 10:16 +0200, Sascha Hauer wrote:
> The following commit changes the function used to copy from/to
> the hardware buffer to memcpy_[from|to]io. This does not work
> since the hardware cannot handle the byte accesses used by these
> functions. Instead of reverting this patch introduce 32bit
> correspondents of these functions.

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/f0d9ca4a/attachment-0001.sig>
