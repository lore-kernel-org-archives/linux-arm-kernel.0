From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Mon, 11 Jul 2016 10:24:28 -0500
Subject: [PATCH] ARM: dts: da850: Add new ECAP and EPWM bindings
In-Reply-To: <577A5AD0.7070906@ti.com>
References: <1467036842-20913-1-git-send-email-fcooper@ti.com>
 <577A5AD0.7070906@ti.com>
Message-ID: <5783BA2C.7030905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/04/2016 07:47 AM, Sekhar Nori wrote:
> On Monday 27 June 2016 07:44 PM, Franklin S Cooper Jr wrote:
>> From: "Cooper Jr., Franklin" <fcooper@ti.com>
>>
>> Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
>> provide the various required clocks.
> 
> there is nothing called hwmod on da850, so this need rewording to make
> sense for that platform.

Sorry will fix.
> 
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Also, documentation needs update as well since it says:
> 
> "
> for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm"
> "
> 

The original patch that Tony pulled in already includes this
documentation update for the new bindings. This patch just handles the
DA850 DT changes that didn't apply when Tony pulled in the original patch.

> Thanks,
> Sekhar
> 
