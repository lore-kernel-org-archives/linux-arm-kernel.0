From: nm@ti.com (Nishanth Menon)
Date: Wed, 17 Dec 2014 11:33:03 -0600
Subject: OMAP 4430 SDP: rather sick with recent kernels
In-Reply-To: <20141217172333.GE23854@atomide.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
Message-ID: <CAGo_u6oS_xyboNZcUsQ8LFrhFhkR6yvr8r_XBj3-yTmqZnqYGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 11:23 AM, Tony Lindgren <tony@atomide.com> wrote:
>
>> twl: not initialized
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660
>
> This seems to be some twl related init order issue, I'll take a
> look at this one.
>
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
>> omap2_set_init_voltage: unable to set vdd_mpu
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_core
>> omap2_set_init_voltage: unable to set vdd_core
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
>> omap2_set_init_voltage: unable to set vdd_iva
>
> I believe Nishanth has some plans for these?


Not in the near future. looks like converting VC/VP into regulator and
fit inside DT world has gone no where..

Regards,
Nishanth Menon

-- 
---
Regards,
Nishanth Menon
