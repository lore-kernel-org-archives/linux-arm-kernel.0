From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 23 Jun 2017 07:53:09 +1000
Subject: new dma-mapping tree, was Re: clean up and modularize arch
 dma_mapping interface V2
In-Reply-To: <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
References: <20170616181059.19206-1-hch@lst.de> <20170620124140.GA27163@lst.de>
 <20170620230400.1a5ae889@canb.auug.org.au>
 <CGME20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365@epcas1p4.samsung.com>
 <20170620131623.GB30769@lst.de>
 <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
Message-ID: <20170623075309.1e679168@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Wed, 21 Jun 2017 15:32:39 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 2017-06-20 15:16, Christoph Hellwig wrote:
> > On Tue, Jun 20, 2017 at 11:04:00PM +1000, Stephen Rothwell wrote:  
> >> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next
> >>
> >> Contacts: Marek Szyprowski and Kyungmin Park (cc'd)
> >>
> >> I have called your tree dma-mapping-hch for now.  The other tree has
> >> not been updated since 4.9-rc1 and I am not sure how general it is.
> >> Marek, Kyungmin, any comments?  
> > I'd be happy to join efforts - co-maintainers and reviers are always
> > welcome.  
> 
> I did some dma-mapping unification works in the past and my tree in 
> linux-next
> was a side effect of that. I think that for now it can be dropped in 
> favor of
> Christoph's tree. I can also do some review and help in maintainers work if
> needed, although I was recently busy with other stuff.

OK, so I have dropped the dma-mapping tree and renamed dma-mapping-hch
to dma-mapping.

-- 
Cheers,
Stephen Rothwell
