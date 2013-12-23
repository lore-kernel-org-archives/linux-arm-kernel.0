From: s-anna@ti.com (Anna, Suman)
Date: Mon, 23 Dec 2013 17:28:13 -0600
Subject: [PATCH 6/7] ARM: OMAP2+: Remove legacy data from hwmod for omap3
 isp iommu
In-Reply-To: <52B8ACED.1030209@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-7-git-send-email-florian.vaussard@epfl.ch>
 <52B88A49.9020402@ti.com> <52B8ACED.1030209@epfl.ch>
Message-ID: <52B8C70D.3040103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

 >>
>> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>>> The data are now passed using the devicetree.
>>
>> Patch is good by itself. A similar change is needed for the IVA
>> MMU as well.
>>
>
> As I understood, the IVA MMU is still not integrated into the iommu
> core, as its implementation lives under staging/tidspbridge/. But
> correct me if I am wrong.
>

Yes, that is correct. That shouldn't stop us though from adding the IVA 
MMU node to the DT file and the associated cleanup. To begin with, we 
can have the DT node added with status=disabled.

regards
Suman
