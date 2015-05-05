From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Tue, 5 May 2015 14:50:52 +0900
Subject: [PATCH v6 25/25] ARM: dts: exynos: add iommu reserved regions for
 bootloader's splash screen
In-Reply-To: <1430727380-10912-26-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-26-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPfOChQb11Y1pZTasFWnXoqPnLy32_989dQ2GN1Aiz4HKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-04 17:16 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Some bootloaders enable FIMD module and configure it as a simple
> framebuffer to display boot logo or splash screen before booting the
> kernel. Such framebuffer stays enabled until proper kernel driver gets
> probbed. Usually it is configured in such a way, that it performs DMA
> from the buffer located in system memory. To avoid IOMMU access fault
> during system boot, additional identity mapping between system memory
> and IO virtual address space must be created when IOMMU driver gets
> enabled.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
