From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 5 Jan 2016 16:47:16 +1100
Subject: Widespread boot failures on ARM due to "mm/page_alloc.c:
 calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <20160105114918.2641f95d@canb.auug.org.au>
References: <20160104224233.GU16023@sirena.org.uk>
 <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
 <20160104235512.GW16023@sirena.org.uk>
 <20160104163528.be56a4b1.akpm@linux-foundation.org>
 <20160105114918.2641f95d@canb.auug.org.au>
Message-ID: <20160105164716.44b9db6d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, 5 Jan 2016 11:49:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Mon, 4 Jan 2016 16:35:28 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Stephen, can we please retain
> > 
> > mm-calculate-zone_start_pfn-at-zone_spanned_pages_in_node.patch
> > mm-introduce-kernelcore=mirror-option.patch
> > mm-introduce-kernelcore=mirror-option-fix.patch
> > mm-introduce-kernelcore=mirror-option-fix-2.patch
> > 
> > and add the below?  
> 
> Sure, that is easier than dropping the above patches, anyway.

I have done that *except* that
mm-introduce-kernelcore=mirror-option-fix-2.patch is not in mmotm and I
cannot find it anywhere.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
