From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Aug 2013 18:18:42 +0900
Subject: [PATCH v2 0/2] R8A7779/Marzen: HPB-DMAC support for SDHI0
In-Reply-To: <521B41AB.8040005@cogentembedded.com>
References: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
 <20130826073626.GB10710@verge.net.au>
 <521B41AB.8040005@cogentembedded.com>
Message-ID: <20130827091841.GA30837@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 03:53:15PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-08-2013 11:36, Simon Horman wrote:
> 
> >>    Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
> >>'renesas-devel-20130823' tag. Here we add the HPB-DMAC platform code working on
> >>R8A7779 and enable DMA for SDHI0 on Marzen. The patchset depends on the R-Car
> >>HPB-DMAC driver patch posted earlier.
> 
> >>[1/2] ARM: shmobile: r8a7779: add HPB-DMAC support
> >>[2/2] ARM: shmobile: Marzen: enable DMA for SDHI0
> 
> >Hi Sergei,
> 
> >have those patches been merged?
> 
>    No. The driver they depend on hasn't been merged yet.
> 
> >If so, do you expect them to appear in v3.12-rc1?
> 
>    I'm not sure what to expect at this point...

Thanks, I understand.

I think that the best thing would be for you to repost this series
once the dependencies have been merge and are available
in a stable branch.
