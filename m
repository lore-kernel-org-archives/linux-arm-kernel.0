From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Thu, 13 Sep 2012 06:23:38 +0000
Subject: [PATCH 2/2] arm/dts: AM33XX: Add device tree OPP table
In-Reply-To: <5050C4B3.9040107@ti.com>
References: <1346405840-31058-1-git-send-email-anilkumar@ti.com>
 <1346405840-31058-3-git-send-email-anilkumar@ti.com>
 <5050C4B3.9040107@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2DF8C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 22:51:55, Cousson, Benoit wrote:
> + Paul
> 
> Hi Anil,
> 
> On 08/31/2012 11:37 AM, AnilKumar Ch wrote:
> > Add DT OPP table for AM33XX family of devices. This data is
> > decoded by OF with of_init_opp_table() helper function.
> > 
> > Also adds cpu0 supply name to the corresponding dts files.
> > cpu0-supply name is used by cpufreq-cpu0 driver to get the
> > regulator pointer for voltage modifications.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> I've just applied your patch in my for_3.7/dts_part2 branch.

Thanks Benoit,

> 
> I changed the subject to use "ARM: dts: " prefix seems it seems to be
> the convention nowadays.

I will take care from next time onwards.

> 
> I can apply as the well the clock patch if Paul acks it, but it can go
> through Paul as well since there is no strong dependency between them AFAIK.

Paul,

Can you ACK "clock data entry" patch?

Thanks
AnilKumar
