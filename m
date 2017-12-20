From: vigneshr@ti.com (Vignesh R)
Date: Wed, 20 Dec 2017 09:45:45 +0530
Subject: [PATCH 1/4] pci: dwc: pci-dra7xx: Enable errata i870 for both EP
 and RC mode
In-Reply-To: <20171219162421.GD21501@red-moon>
References: <20171201061311.16691-1-vigneshr@ti.com>
 <20171201061311.16691-2-vigneshr@ti.com> <20171219162421.GD21501@red-moon>
Message-ID: <fa536894-fac6-feea-e973-268ff5a6389d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 19 December 2017 09:54 PM, Lorenzo Pieralisi wrote:
> On Fri, Dec 01, 2017 at 11:43:08AM +0530, Vignesh R wrote:
>> Errata i870 is applicable in both EP and RC mode. Therefore rename
>> function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
>> workaround, to dra7xx_pcie_unaligned_memaccess() and call it from a
>> common place. So, that errata workaround is applied for both modes of
>> operation.
>> 
>> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>? drivers/pci/dwc/pci-dra7xx.c | 12 ++++++------
>>? 1 file changed, 6 insertions(+), 6 deletions(-)
> 
> I need Kishon's ACK to apply it, thanks.

There are some enhancements to this patch. Will submit a v2 shortly.
Please ignore this version for now. Thanks!


-- 
Regards
Vignesh
