From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 16 Aug 2013 09:18:20 +0900
Subject: linux-next: build failures on Exynos
In-Reply-To: <8738qblxf0.fsf@kernel.org>
References: <8738qblxf0.fsf@kernel.org>
Message-ID: <13b301ce9a16$1ce01a90$56a04fb0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote:
> 
> Hi Kukjin,
> 
Hi,

> The following new build failures started showing up in linux-next
> (next-20130814) when building  the exynos defconfigs below:
> 
> 	arm-exynos5440_defconfig
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma1"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma1"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma0"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma0"
> ERROR: Input tree has errors, aborting (use -f to force output)
> 
> 	arm-exynos_defconfig
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma1"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma1"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma0"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma0"
> ERROR: Input tree has errors, aborting (use -f to force output)
> 
Thanks for your information.

I think it is due to commit 6187288f15bc ("ARM: dts: exynos5250: move common
i2s properties to exynos5 dtsi") which is in Mark Brown's tree. Note, I
added him in Cc in other mail thread from Olof just now.

Thanks again.

- Kukjin
