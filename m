From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 23 Dec 2013 22:36:45 +0100
Subject: [PATCH 6/7] ARM: OMAP2+: Remove legacy data from hwmod for omap3
 isp iommu
In-Reply-To: <52B88A49.9020402@ti.com>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-7-git-send-email-florian.vaussard@epfl.ch>
 <52B88A49.9020402@ti.com>
Message-ID: <52B8ACED.1030209@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On 12/23/2013 08:08 PM, Anna, Suman wrote:
> Hi Florian,
> 
> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>> The data are now passed using the devicetree.
> 
> Patch is good by itself. A similar change is needed for the IVA
> MMU as well.
> 

As I understood, the IVA MMU is still not integrated into the iommu
core, as its implementation lives under staging/tidspbridge/. But
correct me if I am wrong.

Regards,

Florian
