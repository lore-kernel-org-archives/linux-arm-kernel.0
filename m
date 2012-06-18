From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 18 Jun 2012 18:18:39 +0000
Subject: [PATCH-V2 0/4] ARM: OMAP2+: am33xx: Add clocktree and hwmod data
In-Reply-To: <alpine.DEB.2.00.1206181206000.11642@utopia.booyaka.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA50AF1@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206181206000.11642@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA54713@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 23:36:58, Paul Walmsley wrote:
> Hi Vaibhav,
> 
> On Thu, 14 Jun 2012, Hiremath, Vaibhav wrote:
> 
> > Leaving HWMOD data patch aside, both the above patches should be 
> > considered for acceptance, can you please review the same and if there 
> > are no review comments, can it be merged?
> 
> I don't quite understand the part about leaving the hwmod data patch 
> aside.  Is that one not ready?  Or does it need to be modified pending 
> some other series?
> 

It is ready, since I did not get your acked-by or reviewed-by on the patche-
series, so I wanted to get trivial patches merged.

Paul,
I would really recommend you to look at the proposal of getting the clock-
tree and hwmod patches to the linux-next until merge window, so that it will 
get tested for some time.

Also, I am in the process of converting to common-clock framework on top of 
Rajendra's patch-series.

Thanks,
Vaibhav
