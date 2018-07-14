From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 14:28:01 -0700
Subject: [GIT PULL] STM32 DT changes for v4.19 #1
In-Reply-To: <2560c5e6-d749-244c-4ae3-4b04a3d62c36@st.com>
References: <2560c5e6-d749-244c-4ae3-4b04a3d62c36@st.com>
Message-ID: <20180714212801.eo7lbzs47ofdrxcg@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 03:57:40PM +0200, Alexandre Torgue wrote:
> Hi Arnd, Olof and Kevin,
> 
> Please consider this first round of STM32 DT updates for v4.19:
> 
> Thanks.
> Alex
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-dt-for-v4.19-1
> 
> for you to fetch changes up to c2888cc2e2b8fc16164de0cca806763831a36f6f:
> 
>   ARM: dts: stm32: update iwdg with lsi clock name for stm32f429 (2018-07-13
> 13:57:05 +0200)
> 
> ----------------------------------------------------------------
> STM32 DT updates for v4.19, round 1
> 
> Highlights:
> ----------
> 
> -MCU platforms update:
>  -Update RTC syscfg bindings on stm32f746 and stm32f429
>  -Update IWDG node with LSI clock name on stm32f429
> 
> -MPU STM32MP157 platform update:
>  -Add HASH support
>  -Add m_can support and enable it on EV1 board
>  -Add RTC suppoort and enable it on ED1 board
>  -Add USB OTG HS support and enable it on EV1 board
>  -Enable USB Host EHCI on EV1 board
>  -Add DFSDM support
>  -Add SPI support
>  -Add ETH support and enable it on EV1 board
>  -Add IWDG support and enable it on ED1 board
>  -Fix useless GPIO aliases and reorder nodes

Merged, thanks!


-Olof
