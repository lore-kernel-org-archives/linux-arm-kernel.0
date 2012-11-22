From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 22 Nov 2012 12:21:37 +0200
Subject: [PATCH 135/493] mtd: remove use of __devexit_p
In-Reply-To: <1353349642-3677-135-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-135-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353579697.2701.27.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-19 at 13:21 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>

Pushed this one and 238, 314, 363, 415 to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/95ffb8f3/attachment-0001.sig>
