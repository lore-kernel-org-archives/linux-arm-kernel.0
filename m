From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 2 May 2018 16:24:23 +0200
Subject: [PATCH v1 0/4] Add DMAv2 and DMAMUX Support on STM32MP157C
In-Reply-To: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <e720dec2-2ea8-c0ba-cfc9-b8c001c06328@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 04/20/2018 11:14 AM, Pierre-Yves MORDRET wrote:
> This patch adds DMAv2 and DMAMUX support on STM32MP157C with configs and device tree.
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> 
> Pierre-Yves MORDRET (4):
>    ARM: configs: stm32: Add DMAv2 support on STM32MP157C machine
>    ARM: configs: stm32: Add DMAMUX support on STM32MP157C
>    ARM: dts: stm32: Add DMAv2 support on STM32MP157C
>    ARM: dts: stm32: Add DMAMUX support on STM32MP157C
> 
>   arch/arm/boot/dts/stm32mp157c.dtsi | 44 ++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-stm32/Kconfig        |  2 ++
>   2 files changed, 46 insertions(+)
> 
Series applied on stm32-next. As said before I modified commit header 
for mach-stm32/Kconfig patch.

Regards
Alex
