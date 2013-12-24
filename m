From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 11:55:45 +0900
Subject: [PATCH 2/2] ARM: shmobile: Lager: conditionally select
 CONFIG_MICREL_PHY
In-Reply-To: <52B88A28.4090708@cogentembedded.com>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
 <201312200220.54747.sergei.shtylyov@cogentembedded.com>
 <20131223005322.GJ12239@verge.net.au>
 <52B887B2.7070507@cogentembedded.com>
 <52B88A28.4090708@cogentembedded.com>
Message-ID: <20131224025544.GD22401@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 10:08:24PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/23/2013 09:57 PM, Sergei Shtylyov wrote:
> 
> >>>Now that support for KSZ8041RNLI is added to the Micrel PHY driver and we
> >>>intend
> >>>to support PHY IRQs on the Lager board, we have to enable the Micrel driver.
> >>>Do this by selecting CONFIG_MICREL_PHY for Lager if CONFIG_SH_ETH is enabled.
> 
> >>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>Hi Sergei,
> 
> >>while I am very happy to see this change unfortunately it no longer
> >>applies. Could you please rebase it on top of
> >>renesas-devel-v3.13-rc4-20131219?
> 
> >    Hmm, it *was done* on top of this tag. Perhaps you meant today's
> >renesas-devel-v3.13-rc5-20131223?
> 
>    It continues to apply even to that tag seamlessly. Some issue
> must be on your side...

Indeed. I have now queued up the patch.
