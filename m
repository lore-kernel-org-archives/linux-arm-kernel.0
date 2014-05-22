From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 22 May 2014 17:44:21 +0200
Subject: Add SDHCI support for STMicroelectronics SoCs
In-Reply-To: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <537E1B55.1090807@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 05/22/2014 05:18 PM, Peter Griffin wrote:
> This series adds a SDHCI platform driver for ST SoCs, along with
> the additional device tree bindings and configuration to enable
> the controller to work properly.
>
> Initially it supports the stih416 and stih415 SoCs, and has
> been tested on a stih416-b2020 board.

In next version, could you also add  drivers/mmc/host/sdhci-st.c in the 
ARM/STI ARCHITECTURE field of MAINTAINERS file?


Thanks,
Maxime


>
> regards,
>
> Peter.
>
