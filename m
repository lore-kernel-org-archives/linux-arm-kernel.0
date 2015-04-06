From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Apr 2015 10:09:42 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: add EtherAVB DT support
In-Reply-To: <551D2887.3020808@cogentembedded.com>
References: <1625400.M0MxPQybIy@wasted.cogentembedded.com>
 <8163383.0UU0Q5gsLE@wasted.cogentembedded.com>
 <20150331002113.GB16289@verge.net.au>
 <551AB78B.4000506@cogentembedded.com>
 <20150402013359.GB25445@verge.net.au>
 <551D2887.3020808@cogentembedded.com>
Message-ID: <20150406010942.GF23396@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 02:31:19PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 4/2/2015 4:33 AM, Simon Horman wrote:
> 
> >>On 03/31/2015 03:21 AM, Simon Horman wrote:
> 
> >>>>Define the generic R8A7790 part of the EtherAVB device node.
> 
> >>>Please repost once this binding (and associated driver) has been accepted.
> 
> >>    OK, but will you merge patch #1?
> 
> >I would prefer to wait until we can exercise it with a driver.
> 
>    Then you'll have to wait long as the Lager board doesn't have support for
> Ethernet AVB. We've only tested it with the daughter boards.

All the same, I'd rather wait for the driver to be merged first.
