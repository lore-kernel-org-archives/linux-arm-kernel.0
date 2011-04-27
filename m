From: mindentropy@gmail.com (mindentropy)
Date: Wed, 27 Apr 2011 23:37:25 +0530
Subject: Clarification regarding DMA in s3c2440.
In-Reply-To: <201104271841.19619.anarsoul@gmail.com>
References: <201104262146.20149.mindentropy@gmail.com>
	<201104271841.19619.anarsoul@gmail.com>
Message-ID: <201104272337.25880.mindentropy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 Apr 2011 9:11:19 pm Vasily Khoruzhick wrote:
> On Tuesday 26 April 2011 19:16:19 mindentropy wrote:
> > Hi All,
> > 
> >    I am having some trouble understanding the datasheet of s3c2440 CPU in
> > 
> > the DMA part.(I am trying to understand the dma controller code).
> > 
> > In chapter 8 second page under the heading DMA request sources the
> > number of sources should be 7 and not 4.
> 
> True
> 
> > In the s3c2410 the sources
> > are 5 but they have given it as 4.
> 
> s3c2440 has 18 dma sources, but not every channel is valid for some source,
> check arch/arm/mach-s3c2440/dma.c, struct s3c24xx_dma_map - it follows
> table 8-1 in mentioned datasheet.
> 
> Regards
> Vasily

Thanks for the reply. I am following the source. Much clearer there :)
