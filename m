From: padma.kvr@gmail.com (Padma Venkat)
Date: Mon, 12 Aug 2013 15:48:41 +0530
Subject: [PATCH 0/2] Move comon DMA nodes to exynos5.dtsi and
In-Reply-To: <1373458449-19039-1-git-send-email-padma.v@samsung.com>
References: <1373458449-19039-1-git-send-email-padma.v@samsung.com>
Message-ID: <CAAgF-BfjqF-1TcWbZ_nw9Kqrg-xr0H6uMu+u=9N=gaOoq_G2Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Any comment on this patch set?
If not can you take into your tree?

Thanks
Padma

On Wed, Jul 10, 2013 at 5:44 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Exynos5250 and Exynos5420 has 4 DMA controllers in common. So this patch
> set moved the common nodes to exynos.dtsi keeping the clk info seperate
> for both the platforms. Exynos5420 has a separate DMA controller for audio
> IPs. So this patch set also adds the ADMA node on Exynos5420.
>
> Padmavathi Venna (2):
>   ARM: dts: Move the common DMA controller nodes to exynos5.dtsi
>   ARM: dts: Add DMA controller node info on Exynos5420.
>
>  arch/arm/boot/dts/exynos5.dtsi    |   44 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi |   30 -------------------------
>  arch/arm/boot/dts/exynos5420.dtsi |   33 +++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 30 deletions(-)
>
> --
> 1.7.4.4
>
