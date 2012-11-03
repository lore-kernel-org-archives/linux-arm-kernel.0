From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sat, 3 Nov 2012 13:17:50 +0000
Subject: [PATCH 14/15] ARM: OMAP2+: omap2plus_defconfig: Enable Mailbox
In-Reply-To: <50950C09.6000108@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-15-git-send-email-vaibhav.bedia@ti.com>
 <50950C09.6000108@deeprootsystems.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFEA96@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 17:50:25, Kevin Hilman wrote:
> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> > AM33XX PM code depends on Mailbox module for IPC
> > between MPU and WKUP_M3.
> 
> OK, but what if I try to build for AM33xx without starting from 
> omap2plus_defconfig?

I honestly didn't think about this scenario.

> 
> IOW, instead of changing the default defconfig, AM33xx should select 
> this when PM
> is enabled.   Something like the (untested) change below.
> 

Will try it out. Thanks for the suggestion.

Regards,
Vaibhav 
