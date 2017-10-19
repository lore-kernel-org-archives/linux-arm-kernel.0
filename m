From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Thu, 19 Oct 2017 13:27:41 +0000
Subject: [INTERNAL][PATCH 0/7] ASoC: stm32: Add SAI synchronization support
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Message-ID: <85690d88-046e-7092-465e-4a8942a1cb35@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore "[INTERNAL]" in subject.
Sorry for this unappropriated header.

On 10/19/2017 03:03 PM, Olivier Moysan wrote:
> This patch-set adds support of synchronization features for SAI interface.
> It also adds minor fixes and improvements.
> 
> Olivier Moysan (7):
>    ASoC: stm32: Add synchronization to SAI bindings
>    ASoC: stm32: sai: Move static settings to DAI init
>    ASoC: stm32: sai: Fix DMA burst size
>    ASoC: stm32: sai: fix stop management in isr
>    ASoC: stm32: sai: Remove spurious IRQs on stop
>    ASoC: stm32: sai: Fix get reset controller
>    ASoC: stm32: sai: Add synchronization support
> 
>   .../devicetree/bindings/sound/st,stm32-sai.txt     |  14 +-
>   sound/soc/stm/stm32_sai.c                          | 162 ++++++++++++++++++++-
>   sound/soc/stm/stm32_sai.h                          |  22 ++-
>   sound/soc/stm/stm32_sai_sub.c                      | 156 +++++++++++++++++---
>   4 files changed, 318 insertions(+), 36 deletions(-)
> 
