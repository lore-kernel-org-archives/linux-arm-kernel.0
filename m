From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 09:08:19 +0100
Subject: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
In-Reply-To: <81975e6e-b97a-0401-0e18-b2d26722c1dd@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
 <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
 <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
 <20161123020300.GA3481@dhcp-128-65.nay.redhat.com>
 <81975e6e-b97a-0401-0e18-b2d26722c1dd@redhat.com>
Message-ID: <20161123080816.GA30255@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 07:41:52AM +0530, Pratyush Anand wrote:
> 
> 
> On Wednesday 23 November 2016 07:33 AM, Dave Young wrote:
> >>Although this is very unlikely that a hardware will support only 16K page
> >>> sizes, however it is possible. Therefore, its better to keep it disabled by
> >>> default.
> >If it is *unlikely* it could be better to make it as default and add a
> >--disable-dcache instead.
> >
> 
> I think, I can do that.

Can this be detected at run-time?

It sounds like it will be painful if on some setups the default
doesn't work.
