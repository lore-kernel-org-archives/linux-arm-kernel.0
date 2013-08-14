From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 14 Aug 2013 15:28:35 -0700
Subject: linux-next: build failures on Exynos
Message-ID: <8738qblxf0.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

The following new build failures started showing up in linux-next
(next-20130814) when building  the exynos defconfigs below:

	arm-exynos5440_defconfig
ERROR (phandle_references): Reference to non-existent node or label "pdma1"
ERROR (phandle_references): Reference to non-existent node or label "pdma1"
ERROR (phandle_references): Reference to non-existent node or label "pdma0"
ERROR (phandle_references): Reference to non-existent node or label "pdma0"
ERROR: Input tree has errors, aborting (use -f to force output)

	arm-exynos_defconfig
ERROR (phandle_references): Reference to non-existent node or label "pdma1"
ERROR (phandle_references): Reference to non-existent node or label "pdma1"
ERROR (phandle_references): Reference to non-existent node or label "pdma0"
ERROR (phandle_references): Reference to non-existent node or label "pdma0"
ERROR: Input tree has errors, aborting (use -f to force output)

Kevin
