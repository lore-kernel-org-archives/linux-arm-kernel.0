From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 18 Oct 2016 11:26:48 +0100
Subject: [PATCH 3/3] arm64: dts: Update Broadcom NS2 to generic IOMMU
 binding
In-Reply-To: <77abd968-f412-a118-5b19-5faf539f33be@gmail.com>
References: <acf4f770eab43fec8c5b6e9cddb6dd0defc52138.1476706244.git.robin.murphy@arm.com>
 <f2de1b15adb2f57529734a4769ef04d9cde3cc5d.1476706244.git.robin.murphy@arm.com>
 <77abd968-f412-a118-5b19-5faf539f33be@gmail.com>
Message-ID: <8773998a-79f8-509a-3019-9f3022929c10@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/16 01:58, Florian Fainelli wrote:
> On 10/17/2016 05:13 AM, Robin Murphy wrote:
>> With the "mmu-masters" property now deprecated and optional, the
>> generic binding offers a more efficient way to specify no masters.
>>
>> CC: Ray Jui <rjui@broadcom.com>
>> CC: Scott Branden <sbranden@broadcom.com>
>> CC: Jon Mason <jonmason@broadcom.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Applied, did you use get_maintainers.pl for this file? It did not land
> in bcm-kernel-feedback-list at broadcom.com and as such did not get picked
> by the patchwork instance behind..

Oops, sorry! I somehow managed to overlook that - I'll try paying closer
attention in future :)

Thanks,
Robin.
