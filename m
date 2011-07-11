From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 11 Jul 2011 13:05:51 +0800
Subject: [PATCH] ARM: mmp: remove builtin gpio driver support
In-Reply-To: <20110710040218.GA10912@ponder.secretlab.ca>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<20110710040218.GA10912@ponder.secretlab.ca>
Message-ID: <1310360751.4621.6.camel@Lily>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-07-09 at 21:02 -0700, Grant Likely wrote:
> On Fri, Jul 08, 2011 at 06:20:18PM +0800, Haojian Zhuang wrote:
> > Remove builtin gpio driver support form mmp.
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> 
> Hi Haojian.
> 
> I'm not clear what this patch is intending to do.  I understand that
> it removes the mmp-specific gpio support, but I looks like don't see the code
> that replaces it, which would mean that applying this patch breaks
> gpio on mmp platforms.
> 
> Am I missing something?
> 
I'm sorry that I shouldn't loop this patch since my new gpio driver
isn't contained in this patch series.

I'm willing to add one operation to select using original gpio driver or
the new one. Since the original gpio driver is shared between ARCH-PXA
and ARCH-mmp. I don't want patch breaking the implementation in
ARCH-PXA.

Thanks
Haojian
