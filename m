From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 29 Aug 2010 12:42:55 +0200
Subject: [PATCH 0/5] pxa3xx_nand updates
In-Reply-To: <AANLkTikU1oa-WqkraOTGz9re_=rreuikA1uoJk-SeEOR@mail.gmail.com>
References: <AANLkTinU2nF2q9+eSX9XkA3U=Kj3M+BELrDBN1S2AaZp@mail.gmail.com>
	<1282840236.15156.41.camel@localhost>
	<AANLkTikU1oa-WqkraOTGz9re_=rreuikA1uoJk-SeEOR@mail.gmail.com>
Message-ID: <201008291242.55347.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 29. srpna 2010 05:05:26 Haojian Zhuang napsal(a):
> On Fri, Aug 27, 2010 at 12:30 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Fri, 2010-08-27 at 00:22 +0800, Haojian Zhuang wrote:
> >> On Mon, Aug 23, 2010 at 4:22 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> >> > On Wed, Aug 18, 2010 at 10:34 PM, Haojian Zhuang
> >> > 
> >> > <haojian.zhuang@gmail.com> wrote:
> >> >> Changelog from v1:
> >> >> 
> >> >> 1. Add default timing in order to read id successfully.
> >> >> 2. Clean code
> >> > 
> >> > This series looks good to me. David, would you please help
> >> > merge this? Thanks.
> >> 
> >> Hi David,
> >> 
> >> How about this series of patches? If they can be merged, we can
> >> produce new patches from mtd tree.
> > 
> > Please could you resend them -- with Eric's Acked-By, and *without* the
> > line wrap that prevents them from applying.
> > 
> > --
> > dwmw2
> 
> Hi David,
> 
> Eric's Acked-by is added into these patches already. Please help to
> review and merge.
> 
> Since the first patch is already merged, only submit the other 4 patches.

Do you use git send-email by any chance? That shouldn't cause such line-wrap, 
right?

Cheers
> 
> Thanks
> Haojian
