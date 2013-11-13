From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Nov 2013 11:04:46 -0500
Subject: [PATCH V3 7/7] ARM: DRA: Enable Crossbar IP support for DRA7XX
In-Reply-To: <52839B9C.8090707@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-8-git-send-email-r.sricharan@ti.com>
 <5281BF70.4050708@ti.com> <5281C0E9.8020104@ti.com> <52839B9C.8090707@ti.com>
Message-ID: <5283A31E.4070302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 November 2013 10:32 AM, Nishanth Menon wrote:
> On 11/11/2013 11:47 PM, Sricharan R wrote:
[..]

> 
> Rationale - with more TI SoCs trending towards crossbar, we dont need
> to keep adding to the soc_is checks, further, we intend to remove
> soc_is checks in it's entirety..
> 
Just for record, and thats what am pushing the TI hardware folks is not to
build default IRQ configuration considering the software will clean-up the
mess. So hope is that we don't have to use this infrastructure always but
only for exceptional cases.

Regards,
Santosh
