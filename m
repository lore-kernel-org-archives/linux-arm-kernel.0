From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Oct 2016 10:09:05 +0200
Subject: [PATCH v3 0/11] Add R8A7743/SK-RZG1M board support
In-Reply-To: <5be99d76-a082-129b-1aa6-b6f7402ae79b@cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <5be99d76-a082-129b-1aa6-b6f7402ae79b@cogentembedded.com>
Message-ID: <20161012080905.GD31183@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 07:40:34PM +0300, Sergei Shtylyov wrote:
> On 10/06/2016 12:23 AM, Sergei Shtylyov wrote:
> 
> >   Here's the set of 11 patches against Simon Horman's 'renesas.git' repo's
> >'renesas-devel-20161003-v4.8' tag. I'm adding the device tree support for
> >the R8A7743-based SK-RZG1M board. The SoC is close to R8A7791 and the board
> >seems identical to the R8A7791/Porter board. The device tree patches depend on
> >the R8A7743 CPG/MSSR driver series just posted in order to compile and work.
> 
>    Forgot to mention that this version causes a regression with the sh_eth
> driver (well, actually with phylib): since IRQC now gets a deferred probing,
> PHY IRQ doesn't work anymore -- phylib falls back to polling.

Is there a resolution to that problem?
