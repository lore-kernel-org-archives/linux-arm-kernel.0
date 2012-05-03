From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 03 May 2012 13:54:45 +0300
Subject: [PATCH v3] mtd: gpmi: add device tree support for mx6q and mx28
In-Reply-To: <20120502144008.GF2194@S2101-09.ap.freescale.net>
References: <1335939209-15625-1-git-send-email-b32955@freescale.com>
 <20120502144008.GF2194@S2101-09.ap.freescale.net>
Message-ID: <1336042485.13013.41.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-02 at 22:40 +0800, Shawn Guo wrote:
> On Wed, May 02, 2012 at 02:13:28PM +0800, Huang Shijie wrote:
> > add gpmi support for mx6q.
> > add DT support to mx6q and mx28.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
> Hi Artem,
> 
> As the patch heavily depends on mxs device tree branch, I think it will
> be easier to have it go through arm-soc tree.  If you agree, can you
> please give your ack if the patch looks fine to you?

I do not mind if it goes via the arm-soc tree. I cannot really review
this patch - it is too big, I think it should be split on smaller
chunks.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120503/11b13754/attachment.sig>
