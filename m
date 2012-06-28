From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 28 Jun 2012 14:40:27 +0000
Subject: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
In-Reply-To: <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5D46A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 07:04:38, Paul Walmsley wrote:
> On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:
> 
> > In case of AM33xx family of devices (like cpsw) have different sysc
> > bit field offsets defined,
> > 
> > sysc_type3:
> > |  3     2  |  1    0  |
> > | STDBYMODE | IDLEMODE |
> > 
> > So introduce new sysc_type3 in omap_hwmod common data.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Thanks, queued for 3.5.
> 

We missed this patch last time, can you pleas make sure to include it this 
time.

Thanks,
Vaibhav
