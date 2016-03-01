From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Mar 2016 10:05:13 -0800
Subject: [PATCH v3 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
In-Reply-To: <56D59100.3060803@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-4-git-send-email-fcooper@ti.com>
 <20160229232348.GV13417@atomide.com> <56D59100.3060803@ti.com>
Message-ID: <20160301180513.GA13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160301 04:54]:
> On 03/01/2016 01:23 AM, Tony Lindgren wrote:
> >
> >Note for Tero, let's plan on getting rid of the duplicate
> >reg entries by using the standard clock output offset within
> >the clock register. I think we should easily be able to add
> >a binding for this and then deprecate the overlapping reg
> >entries.
> 
> Yeah, we have been discussing this offline a bit, but haven't had time to
> look at this. I believe the hwmod clock conversion is of higher priority
> still.

Yes agreed.

Tony
