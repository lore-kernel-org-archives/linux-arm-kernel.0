From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 13:18:25 +0100
Subject: [PATCH v6 2/4] ARM: dts: Fix STi boards compatibles
In-Reply-To: <1400579192-17620-3-git-send-email-maxime.coquelin@st.com>
References: <1400579192-17620-1-git-send-email-maxime.coquelin@st.com>
 <1400579192-17620-3-git-send-email-maxime.coquelin@st.com>
Message-ID: <20140520121825.GM24991@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 May 2014, Maxime COQUELIN wrote:

> The compatible strings have to be ordered from specific to generic.
> This patch fixes this for STi boards, which did the exact opposite.
> 
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  arch/arm/boot/dts/stih415-b2000.dts | 2 +-
>  arch/arm/boot/dts/stih415-b2020.dts | 2 +-
>  arch/arm/boot/dts/stih416-b2000.dts | 3 +--
>  arch/arm/boot/dts/stih416-b2020.dts | 3 +--
>  4 files changed, 4 insertions(+), 6 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
