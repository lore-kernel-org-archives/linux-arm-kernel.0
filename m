From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 13 Apr 2012 19:09:33 +0300
Subject: [PATCH] mtd/gpmi : do not include the mxs.h
In-Reply-To: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
References: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
Message-ID: <1334333373.13160.4.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-03-31 at 22:36 -0400, Huang Shijie wrote:
> The mxs.h does not exit in the mx6q.
> So rewrite the __mxs_clrl()/__mxs_setl() and remove the mxs.h.
> 
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

Pushed  to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/41569744/attachment.sig>
