From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 17:10:26 +0100
Subject: [PATCH 0/2] RTC support on STM32H743
In-Reply-To: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
References: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <d53b5d88-1efa-36ca-e989-bad441d6cb96@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 02/16/2018 02:16 PM, Amelie Delaunay wrote:
> This patchset add support for RTC on STM32H743 and enables it on stm32h743i-eval.
> Tested on stm32-next.
> 
> Amelie Delaunay (2):
>    ARM: dts: stm32: add RTC support on STM32H743
>    ARM: dts: stm32: enable RTC on stm32h743i-eval
> 
>   arch/arm/boot/dts/stm32h743.dtsi      | 15 +++++++++++++++
>   arch/arm/boot/dts/stm32h743i-eval.dts |  4 ++++
>   2 files changed, 19 insertions(+)
> 

Kbuild issue occurs on patch1 because MAINTAINER file is not correct for 
ARM/STM32. I send a patch to fix it: 
https://lkml.org/lkml/2018/2/26/386. There is no Kbuild issue if patches 
are applied on the correct branch: 
git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next.

So series applied on stm32-next.

regards
Alex
