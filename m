From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 8 Nov 2012 13:05:18 +0000
Subject: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <87pq3p72s7.fsf@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
 <87txt4aqyc.fsf@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EC04AE5@DBDE01.ent.ti.com>
 <87r4o68bnl.fsf@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EC085EE@DBDE01.ent.ti.com>
 <87pq3p72s7.fsf@deeprootsystems.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC0B451@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 22:45:20, Kevin Hilman wrote:
[...]
> >> 
> >
> > We could perhaps add a couple of APIs to check the SYSC values when coming
> > out of suspend and take appropriate action if the sysc cache does not match?
> 
> Yes, for IPs with only SW support and no drivers, we may need something
> like this.  But again, it needs to be suspend and idle aware, not just
> suspend.
> 

Ok, if the pwrmdm pre and post transition callbacks do this that should take
care of both suspend and idle.

Regards,
Vaibhav
