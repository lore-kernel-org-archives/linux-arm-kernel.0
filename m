From: nm@ti.com (Nishanth Menon)
Date: Tue, 17 Sep 2013 09:33:40 -0500
Subject: [PATCH RFC v3 08/12] ARM: OMAP2+: CM: AM43x clockdomain data
In-Reply-To: <523867AD.9080905@ti.com>
References: <cover.1379337301.git.afzal@ti.com>
 <5dd3b417a32b7d52c7de1e19e69e6100b1ed991b.1379337301.git.afzal@ti.com>
 <52372317.3000901@ti.com> <523867AD.9080905@ti.com>
Message-ID: <52386844.9070501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2013 09:31 AM, Afzal Mohammed wrote:
> Hi Nishant,
> 
> On Monday 16 September 2013 08:56 PM, Nishanth Menon wrote:
>> On 09/16/2013 08:48 AM, Afzal Mohammed wrote:
> 
>>> From: Ambresh K <ambresh@ti.com>
>>>
>>> Add the data file to describe clock domains in AM43x SoC.
>>> OMAP4 clockdomain operations is being reused here.
>>>
>>> Signed-off-by: Ambresh K <ambresh@ti.com>
>>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/clockdomain.h           |   2 +
>>>  arch/arm/mach-omap2/clockdomains43xx_data.c | 199 ++++++++++++++++++++++++++++
>>>  arch/arm/mach-omap2/cminst44xx.c            |   9 ++
>>>  3 files changed, 210 insertions(+)
>>>  create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
>>
>> I suggest we drop this. this can be addressed by Tero's clk series.
> 
> Probably you misunderstood clock domain data as clock data, as Tero's
> series does not take care of clock domain data, we would require this.

Arrgh.. yes - my bad. thanks for clarifying.


-- 
Regards,
Nishanth Menon
