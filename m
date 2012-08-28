From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 28 Aug 2012 12:21:01 +0000
Subject: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
In-Reply-To: <503BD8D5.5060400@ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
 <50359C64.40603@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA63D@DBDE01.ent.ti.com>
 <503BD8D5.5060400@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DA81D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Aug 28, 2012 at 02:00:13, Hunter, Jon wrote:
> On 08/27/2012 05:37 AM, Mohammed, Afzal wrote:

> > And at least for initial users, they are expected to have
> > some grasp on how to calculate timings, such a user will
> > not be much worried about your 3 concerns above, anyway as
> > of now they need to have a good grasp on it.
> 
> I would consider myself to be an initial user and I am concerned,
> doesn't that count?

Yes sir, what I meant was new users who want to have runtime
calculation using the generic timing routine. For the
peripherals already making use of custom timing routine,
I am into that role too, hence the patches 8-10.

And if you have any board that makes use of existing custom
timing calculation routines (OneNAND, tusb6010 or smc91x),
can you please give this series a try.

Regards
Afzal
