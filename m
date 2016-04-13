From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 15:16:53 -0700
Subject: [PATCH v3 3/4] arm64: dts: Add dts files for LG Electronics's
 lg1312 SoC
In-Reply-To: <1460375687-2375-4-git-send-email-chanho.min@lge.com>
References: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
 <1460375687-2375-4-git-send-email-chanho.min@lge.com>
Message-ID: <20160413221653.GC19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 08:54:46PM +0900, Chanho Min wrote:
> Add initial dtsi file to support lg1312 SoC which based on
> Cortex-A53. Also add dts file to support lg1312 reference board
> which based on lg1312 SoC.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
> Changes for v2:
> 	- remove self-defined macro.
> 	- change root node's #size-cells to <2>.
> 	- remove bootargs property.
> 	- update psci support to the arm,psci-0.2.
> 	- put fixed-clock property under the root node.
> 	- add stdout-path property.
> 	- update the GICC reg length to 0x2000
> 	- add the GICH and GICV interface.
> 	- change pmu compatible property to arm,coretex-a53-pmu.
> 	- remove clock-frequency property from timer.
> 
> Changes for v3:
> 	- change the order of arm,psci-0.2 and arm,psci

Applied.


-Olof
