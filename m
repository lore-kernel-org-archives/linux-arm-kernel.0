From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 14:39:15 +0900
Subject: [PATCH 1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ
In-Reply-To: <52BD66A2.4050504@cogentembedded.com>
References: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
 <201312200228.00555.sergei.shtylyov@cogentembedded.com>
 <20131227021227.GC9184@verge.net.au>
 <52BD66A2.4050504@cogentembedded.com>
Message-ID: <20140106053915.GF24653@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 27, 2013 at 03:38:10PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 27-12-2013 6:12, Simon Horman wrote:
> 
> >>Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> >>trigger type to be low-level as per the Micrel PHY driver's setup.
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >Hi Sergei,
> 
> >does this depend on changes that have been queued up in net or net-next
> >since v3.13-rc1?
> 
>    Yes, in net-next.
> 
> >If so are they present in v3.13-rc5?
> 
>    No, they should be available in 3.14-rc1.
> 
> >If not please
> >repost when an rc release with the required dependencies is available.
> 
>    You mean this patch should inevitably wait for 3.15? I hoped
> either you or DaveM could still queue this patch for 3.14...

Sorry, it was too late for v3.14 and I would prefer if you didn't route
this via Dave's tree.
