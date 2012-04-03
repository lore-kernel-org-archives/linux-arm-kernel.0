From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 3 Apr 2012 21:39:20 +0200
Subject: [PATCH] mtd/gpmi : do not include the mxs.h
In-Reply-To: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
References: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
Message-ID: <20120403193920.GC2201@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 10:36:57PM -0400, Huang Shijie wrote:
> The mxs.h does not exit in the mx6q.
> So rewrite the __mxs_clrl()/__mxs_setl() and remove the mxs.h.
> 
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

I am quite sure we will have STMP devices in 3.5 which should make this patch
obsolete. If this patch is considered a bugfix for 3.4, then OK for now.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120403/8c3aa7c5/attachment-0001.sig>
