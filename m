From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 25 Jun 2018 12:12:03 +0200
Subject: [PATCH 0/2] ARM: dts: stm32: update rtc st,syscfg
In-Reply-To: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
References: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <7f9e00a5-f00a-22cb-721e-45ea4a5f14bb@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 05/09/2018 05:18 PM, Amelie Delaunay wrote:
> With the lastest STM32 RTC driver updates, it is mandatory to define
> pwrcfg control register and DBP (Disable Backup Protection) bit through
> st,syscfg property. This patchset updates RTC nodes on stm32f429 and
> stm32f746 accordingly.
> 
> Amelie Delaunay (2):
>    ARM: dts: stm32: update rtc st,syscfg property on stm32f429
>    ARM: dts: stm32: update rtc st,syscfg property on stm32f746
> 
>   arch/arm/boot/dts/stm32f429.dtsi | 2 +-
>   arch/arm/boot/dts/stm32f746.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
