From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 9 Jan 2017 12:08:01 -0800
Subject: [PATCH 0/5] Reset Controller Nodes for TI Keystone platforms
In-Reply-To: <20170109194358.27271-1-s-anna@ti.com>
References: <20170109194358.27271-1-s-anna@ti.com>
Message-ID: <efd6ca8e-8c5d-0e24-1cb9-ba412cec1fce@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/9/2017 11:43 AM, Suman Anna wrote:
> Hi Santosh,
>
> This patch adds the reset controller nodes and the corresponding
> reset data for TI Keystone 66AK2H, 66AK2L and 66AK2E SoCs. These
> resets are for the DSPs on these SoCs, and are the last dependencies
> before the keystone remoteproc driver can be added.
>
> All these SoCs will use the ti-syscon-reset driver which is already
> part of mainline kernel. The bindings for the same can be found in
> Documentation/devicetree/bindings/reset/ti-syscon-reset.txt file.
> Note that the other Keystone 66AK2G SoC will use a different TI-SCI
> based reset driver, so will be submitted separately once the TI-SCI
> dependencies make it into mainline.
>
> Patches are based on top of 4.10-rc1 plus the MSM-RAM DT node series
> that you have already picked up. Patch 1 enable the Reset Framework
> for Keystone platforms, and remaining patches add the required DT
> nodes.
>
Ok. I will let this series be on list for a week or so for any
comments. After that will pick this up and push it out to next.

Regards,
Santosh
