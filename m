From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Aug 2015 16:11:14 -0700
Subject: [PATCH 0/2] Add VIN and ADV7180 device tree support for
 R8A7794/SILK board
In-Reply-To: <55D6363F.4050207@cogentembedded.com>
References: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
 <20150820185435.GE18990@verge.net.au>
 <55D624AD.7060801@cogentembedded.com>
 <55D6363F.4050207@cogentembedded.com>
Message-ID: <20150820231114.GN18990@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:19:11PM +0300, Sergei Shtylyov wrote:
> On 08/20/2015 10:04 PM, Sergei Shtylyov wrote:
> 
> >>>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
> >>>'renesas-devel-20150819-v4.2-rc7' tag. Here we add the VIN and ADV7180
> >>>video decoder device tree support on the R8A7794/SILK board. The patchset
> >>>requires previously posted SILK SDHI1 support patch in order to apply and
> >>>R8A7794/SILK I2C1 support in order to apply and build.
> >>>
> >>>[1/2] ARM: shmobile: r8a7794: add VIN DT support
> >>>[2/2] ARM: shmobile: silk: add VIN0/ADV7180 DT support
> >>
> >>Thanks, I have queued these up for v4.4.
> >
> >    Perhaps a bit too early: the PFC VIN patch hasn't been merged yet. Sorry
> >for not specifying the PFC dependency...
> 
>    OTOH, the frames get captured somehow even without the PFC patch, so
> might as well leave these patches applied. Your choice...

Thanks. I will defer these patches for now.
