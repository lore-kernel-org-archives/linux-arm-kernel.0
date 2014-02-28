From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Feb 2014 14:42:06 -0600
Subject: [PATCHv2 08/16] ARM: OMAP3: remove deprecated
 CONFIG_OMAP_IOMMU_IVA2
In-Reply-To: <alpine.DEB.2.02.1402281958170.453@utopia.booyaka.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-9-git-send-email-s-anna@ti.com>
 <alpine.DEB.2.02.1402281958170.453@utopia.booyaka.com>
Message-ID: <5310F49E.4040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On 02/28/2014 01:58 PM, Paul Walmsley wrote:
> On Thu, 13 Feb 2014, Suman Anna wrote:
>
>> From: Florian Vaussard <florian.vaussard@epfl.ch>
>>
>> CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
>> usage by tidspbridge and other iommu users. The same can be achieved
>> by marking the DT node disabled, so remove this obsolete flag and
>> the corresponding hwmod data can be enabled.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> [s-anna at ti.com: revise commit log]
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
> Am assuming that someone else will be merging this as part of the entire
> series.
>

Thanks, I am expecting Tony to pick up all the arch/arm/mach-omap2/ 
patches. I am just about to send the v3 including all the acks received 
so far.

regards
Suman
