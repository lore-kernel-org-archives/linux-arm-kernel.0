From: sstabellini@kernel.org (Stefano Stabellini)
Date: Sat, 21 May 2016 15:09:12 +0100 (BST)
Subject: [PATCH 0129/1529] Fix typo
In-Reply-To: <alpine.DEB.2.10.1605211418190.2958@sstabellini-ThinkPad-X260>
References: <20160521115307.6132-1-andrea.gelmini@gelma.net>
 <alpine.DEB.2.10.1605211418190.2958@sstabellini-ThinkPad-X260>
Message-ID: <alpine.DEB.2.10.1605211508460.2958@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 21 May 2016, Stefano Stabellini wrote:
> On Sat, 21 May 2016, Andrea Gelmini wrote:
> > Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> > ---
> >  arch/arm/xen/mm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> > index c5f9a9e..483da5e 100644
> > --- a/arch/arm/xen/mm.c
> > +++ b/arch/arm/xen/mm.c
> > @@ -150,7 +150,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
> >  	 *	- The Linux page refers to foreign memory
> >  	 *	- The device doesn't support coherent DMA request
> >  	 *
> > -	 * The Linux page may be spanned acrros multiple Xen page, although
> > +	 * The Linux page may be spanned across multiple Xen page, although
> 
> Since you are at it, please also fix the lacking plural. It should be:
> 
> The Linux page may be spanned across multiple Xen pages, although

But given that this is patch 129 of 1529:

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
