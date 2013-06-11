From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jun 2013 09:50:15 +0100
Subject: [PATCH 4/9] ARM: dma-mapping: NULLify dev->archdata.mapping
 pointer on detach
In-Reply-To: <20130611.083455.1500863288897785600.hdoyu@nvidia.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-5-git-send-email-will.deacon@arm.com>
 <20130611.083455.1500863288897785600.hdoyu@nvidia.com>
Message-ID: <20130611085015.GC24729@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 06:34:55AM +0100, Hiroshi Doyu wrote:
> Hi Will,
> 
> Will Deacon <will.deacon@arm.com> wrote @ Mon, 10 Jun 2013 20:34:40 +0200:
> 
> > The current code only clobbers a local variable, so the device is left
> > with a stale mapping pointer.
> 
> True. This's my bad. Thanks.

That's alright, it's easy to fix. Mind if I add your ack please?

Will
