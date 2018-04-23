From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 23 Apr 2018 10:51:49 +0200
Subject: [PATCH v1 0/4] Add DMAv2 and DMAMUX Support on STM32MP157C
In-Reply-To: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <ad5373d4-13b4-319f-5dce-6b8c735a9851@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

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

For patches located in mach-stm32, for the next time I prefer that you 
format commit header as following:

ARM: stm32: Add DMAv2 support on STM32MP157C.....

I don't see other issue, so don't resend for that, I will change it.

Regards
Alex


>    ARM: dts: stm32: Add DMAv2 support on STM32MP157C
>    ARM: dts: stm32: Add DMAMUX support on STM32MP157C
> 
>   arch/arm/boot/dts/stm32mp157c.dtsi | 44 ++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-stm32/Kconfig        |  2 ++
>   2 files changed, 46 insertions(+)
> 
