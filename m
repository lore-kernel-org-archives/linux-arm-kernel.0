From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Jul 2018 18:16:13 +0100
Subject: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <alpine.DEB.2.21.1807042137330.28271@nanos.tec.linutronix.de>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
 <20180627141348.21777-3-toshi.kani@hpe.com>
 <20180627155632.GH30631@arm.com>
 <1530115885.14039.295.camel@hpe.com>
 <20180629122358.GC17859@arm.com>
 <1530287995.14039.361.camel@hpe.com>
 <alpine.DEB.2.21.1807032301140.1816@nanos.tec.linutronix.de>
 <20180704173605.GB9668@arm.com>
 <alpine.DEB.2.21.1807042137330.28271@nanos.tec.linutronix.de>
Message-ID: <20180705171612.GB25425@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 09:39:50PM +0200, Thomas Gleixner wrote:
> On Wed, 4 Jul 2018, Will Deacon wrote:
> > On Tue, Jul 03, 2018 at 11:02:15PM +0200, Thomas Gleixner wrote:
> > 
> > > I just pick it up and provide Will a branch to pull that lot from.
> > 
> > Thanks, Thomas. Please let me know once you've pushed something out.
> 
> Just pushed it out into tip x86/mm branch. It's based on -rc3 and you can
> consume it up to
> 
>   5e0fb5df2ee8 ("x86/mm: Add TLB purge to free pmd/pte page interfaces")
> 
> Please wait until tomorrow morning so the 0day robot can chew on it. If
> nothing breaks, then it should be good to pull from.

Great, thanks Thomas. It looks like the bot's happy with that, so I've
pulled it locally and I'll push it out as part of the arm64 for-next/core
branch tomorrow, after some basic tests.

Will
