From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 7 Jun 2012 18:09:03 +0000
Subject: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <alpine.DEB.2.00.1206070107530.6684@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061309.25532.13430.stgit@dusk>
 <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206070107530.6684@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA44DD9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 12:38:50, Paul Walmsley wrote:
> Hi
> 
> On Thu, 7 Jun 2012, Hiremath, Vaibhav wrote:
> 
> > Isn't this impact AM33xx devices, where we do not support smart idle mode???
> > Anyway, I will also test it on both OMAP3EVM and AM33xx platform now...
> 
> Thanks, please let me know how your tests go.  If it doesn't work, we'll 
> go back to the flag-based approach in the patch I posted already.  
> 

Paul,

I couldn't finish my testing today, got into continuous meetings.
Tomorrow, I will test it and update you on this.

Thanks,
Vaibhav
