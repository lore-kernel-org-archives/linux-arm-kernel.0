From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 18 Nov 2016 14:45:01 +0100
Subject: [RFT] ARM: dts: exynos: Fix invalid GIC interrupt flags in audio
 block of Exynos5410
In-Reply-To: <1479473964-9085-1-git-send-email-krzk@kernel.org>
References: <CGME20161118125944epcas5p16ff6afeb8e4d286adecad6d1344734de@epcas5p1.samsung.com>
 <1479473964-9085-1-git-send-email-krzk@kernel.org>
Message-ID: <64c5dabd-666d-056d-b761-20350bd3372c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2016 01:59 PM, Krzysztof Kozlowski wrote:
> Recently added audio block of Exynos5410 missed global fixup of GIC
> interrupt flags.  Interrupt of type IRQ_TYPE_NONE is not allowed for GIC
> interrupts so use level high.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
