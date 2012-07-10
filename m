From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 01:43:35 -0700
Subject: [RESEND PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate
 class
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA699EE@DBDE01.ent.ti.com>
References: <1341320447-18918-1-git-send-email-hvaibhav@ti.com>
 <1341320447-18918-2-git-send-email-hvaibhav@ti.com>
 <20120704072454.GO1122@atomide.com>
 <20120704081546.GR1122@atomide.com>
 <20120705152743.GG1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA699EE@DBDE01.ent.ti.com>
Message-ID: <20120710084335.GP1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120710 01:43]:
>
> Can we clean these branches; it is very confusing to track with so many 
> multiple versions?

Yeah I'll drop some after the merge window..
 
> Also, One patch still has not merged is,
> 
> [PATCH-V2] ARM: OMAP: cpu: Make cpu_class_is_omap2 true for all non-omap1 platforms
> 
> Do you have any comments on this? If not, can you merge it?

Posted some comments on it, we need to fix that properly for v3.7
merge window.

Tony
