From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Jun 2013 10:59:33 +0200
Subject: [PATCH 4/9] ARM: dma-mapping: NULLify dev->archdata.mapping
 pointer on detach
In-Reply-To: <20130611123933.4d278ff4e056f395788ad060@nvidia.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-5-git-send-email-will.deacon@arm.com>
 <20130611.083455.1500863288897785600.hdoyu@nvidia.com>
 <20130611085015.GC24729@mudshark.cambridge.arm.com>
 <20130611123933.4d278ff4e056f395788ad060@nvidia.com>
Message-ID: <51C172F5.8040500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 6/11/2013 11:39 AM, Hiroshi Doyu wrote:
> On Tue, 11 Jun 2013 10:50:15 +0200
> Will Deacon <will.deacon@arm.com> wrote:
>
> > On Tue, Jun 11, 2013 at 06:34:55AM +0100, Hiroshi Doyu wrote:
> > > Hi Will,
> > >
> > > Will Deacon <will.deacon@arm.com> wrote @ Mon, 10 Jun 2013 20:34:40 +0200:
> > >
> > > > The current code only clobbers a local variable, so the device is left
> > > > with a stale mapping pointer.
> > >
> > > True. This's my bad. Thanks.
> >
> > That's alright, it's easy to fix. Mind if I add your ack please?
>
> Feel free to add: Acked-by: Hiroshi Doyu <hdoyu@nvidia.com>

Thanks for spotting the bug. I've taked the patch to my dma-mapping tree.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
