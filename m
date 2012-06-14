From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 08:45:27 +0000
Subject: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
In-Reply-To: <4FD8B448.9090405@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com>
 <4FD66666.8060002@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998201@DBDE01.ent.ti.com>
 <4FD785DC.2000106@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998820@DBDE01.ent.ti.com>
 <4FD8B448.9090405@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9996E2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 21:09:52, Hunter, Jon wrote:

> Sure, but reviewing the function it still looks odd from a readability
> standpoint. At least it made me think "what is going on here ...". So a
> comment is definitely needed.
> 
> >>
> >> 2. A bad setting in the configuration passed. Hopefully, people will
> >> stick to the flags but we know that we expect the device type to be a 0
> >> or 2 and so should we check?
> > 
> > Value of device type is something driver has to worry about, not its users,
> > they have been provided with two flags, one for NAND & other for NOR.
> 
> Yes, but the driver does not seem to worry about it. In other words,
> there is no error checking. Ok so not a big deal a comment should suffice.

Ok, comments will be added to make intentions clear

Regards
Afzal
