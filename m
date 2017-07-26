From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 26 Jul 2017 18:24:46 +0200
Subject: [PATCH 0/3] ARM: dts: stm32: Remove rdinit from bootargs
In-Reply-To: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
References: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <c38e634a-0475-4541-1127-b7a2fb390daa@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/17/2017 10:36 AM, Alexandre TORGUE wrote:
> This series remove rdinit from bootargs on stm32f4 boards (429-eval,
> 429-disco, 469-disco). Indeed, rootfs is independent from boards.
> Furthermore it will align stm32 F4 devicetree on stm32 F7/H7 one.
> 
> Regards
> Alex
> 
> Alexandre TORGUE (3):
>    ARM: dts: stm32: Remove rdinit from bootargs on stm32f469-disco
>    ARM: dts: stm32: Remove rdinit from bootargs on stm32f429i-eval
>    ARM: dts: stm32: Remove rdinit from bootargs on stm32f429-disco
> 
>   arch/arm/boot/dts/stm32429i-eval.dts  | 2 +-
>   arch/arm/boot/dts/stm32f429-disco.dts | 2 +-
>   arch/arm/boot/dts/stm32f469-disco.dts | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
Series applied on stm32-dt-for-v4.14 branch.
