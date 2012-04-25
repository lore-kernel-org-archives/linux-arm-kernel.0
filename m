From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 25 Apr 2012 10:31:50 +0300
Subject: [PATCH 11/19] ARM: OMAP4: PM: save/restore CM L3INSTR
 registers when MPU hits OSWR/OFF mode
In-Reply-To: <4F96E9A2.8080908@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-12-git-send-email-t-kristo@ti.com>
 <4F96E9A2.8080908@ti.com>
Message-ID: <1335339110.2149.108.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-04-24 at 12:57 -0500, Jon Hunter wrote:
> Hi Tero,
> 
> On 04/20/2012 04:33 AM, Tero Kristo wrote:
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
> > overwrites the CM L3INSTR registers. So to avoid this, save them and
> > restore on the way out from MPU OSWR/OFF.
> 
> This appears to be an errata. So, it would be good to state explicitly
> here that all revisions of all omap4 devices are impacted by this
> errata. The code implies this but for documentation purposes it would be
> worth stating.

Okay, I'll add some extra beef here.

-Tero
