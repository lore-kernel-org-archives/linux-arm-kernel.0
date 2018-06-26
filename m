From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 11:27:59 +0200
Subject: [PATCH 0/2] Add USB OTG HS support on stm32mp157c
In-Reply-To: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
References: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <be346ccb-908d-0af2-7499-4a45b780692e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie

On 05/17/2018 05:47 PM, Amelie Delaunay wrote:
> This patchset adds support for USB OTG HS on stm32mp157c SoC.
> It also enables USB OTG HS on stm32mp157c-ev1 board in Peripheral mode.
> 
> Amelie Delaunay (2):
>    ARM: dts: stm32: add USB OTG HS support for stm32mp157c SoC
>    ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp157c-ev1.dts |  7 +++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 15 +++++++++++++++
>   2 files changed, 22 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
