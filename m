From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 17 Oct 2016 17:58:05 -0700
Subject: [PATCH 3/3] arm64: dts: Update Broadcom NS2 to generic IOMMU
 binding
In-Reply-To: <f2de1b15adb2f57529734a4769ef04d9cde3cc5d.1476706244.git.robin.murphy@arm.com>
References: <acf4f770eab43fec8c5b6e9cddb6dd0defc52138.1476706244.git.robin.murphy@arm.com>
 <f2de1b15adb2f57529734a4769ef04d9cde3cc5d.1476706244.git.robin.murphy@arm.com>
Message-ID: <77abd968-f412-a118-5b19-5faf539f33be@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2016 05:13 AM, Robin Murphy wrote:
> With the "mmu-masters" property now deprecated and optional, the
> generic binding offers a more efficient way to specify no masters.
> 
> CC: Ray Jui <rjui@broadcom.com>
> CC: Scott Branden <sbranden@broadcom.com>
> CC: Jon Mason <jonmason@broadcom.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied, did you use get_maintainers.pl for this file? It did not land
in bcm-kernel-feedback-list at broadcom.com and as such did not get picked
by the patchwork instance behind..
-- 
Florian
