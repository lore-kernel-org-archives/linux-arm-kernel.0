From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 2 May 2018 16:25:06 +0200
Subject: [PATCH v1 0/2] Add MDMA Support on STM32MP157C
In-Reply-To: <1524215707-14642-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215707-14642-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <0bcb0bea-cdc1-483e-4396-517d33e9e69f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/20/2018 11:15 AM, Pierre-Yves MORDRET wrote:
> This patch adds MDMA support on STM32MP157C with configs and device tree.
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> 
> Pierre-Yves MORDRET (2):
>    ARM: configs: stm32: Add MDMA support on STM32MP157C
>    ARM: dts: stm32: Add MDMA support on STM32MP157C
> 
>   arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
>   arch/arm/mach-stm32/Kconfig        |  1 +
>   2 files changed, 11 insertions(+)
> 

Series applied on stm32-next.
As said before I modified commit header for mach-stm32/Kconfig patch.

Regards
Alex
