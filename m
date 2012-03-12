From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 12 Mar 2012 10:13:45 +0000
Subject: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317A918A@DBDE01.ent.ti.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
 <4F3E545F.8070802@ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317A918A@DBDE01.ent.ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A831810F02@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 10:49:47, Bedia, Vaibhav wrote:
> Hi Benoit,
> 
> On Fri, Feb 17, 2012 at 18:51:35, Cousson, Benoit wrote:
> > Hi Vaibhav,
> > 
> > On 2/17/2012 1:24 PM, Vaibhav Hiremath wrote:
> > > In case of AM33xx family of devices (like cpsw) have different sysc
> > > bit field offsets defined,
> > 
> > It is really used by several IPs, or it is just an unique exception?
> > 
> > For an exception, you can just define the omap_hwmod_sysc_fields for 
> > that IP.
> > This is what SmartReflex is using for example.
> > 
> 
> I haven't really check TI81xx code but we might need to share these SYSC types
> with a few IPs in that family also. How can the sharing of the sysc data be handled?
> 

Benoit,

Any comments on this patch? 

Thanks,
Vaibhav

> Regards,
> Vaibhav B.
> 
