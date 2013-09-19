From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Sep 2013 13:03:48 +0100
Subject: [PATCH 0/2] Fixes for STi SOCs
In-Reply-To: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
References: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130919120348.GH22389@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Arnd/Olof, 
> 
> These two are very minor fixes for STi SOCs.
> One of the fix is a typo and other is to add two new options to
> multi_v7_defconfig to get STi SOC based boards boot with nfs root with serial
> console.

If these are accepted, it would be a massive help to get them into
v3.12.

> Srinivas Kandagatla (2):
>   ARM: STi: OF: Fix a typo in pincfg header
>   ARM: multi_v7_defconfig: Fix STi support
> 
>  arch/arm/boot/dts/st-pincfg.h       |    2 +-
>  arch/arm/configs/multi_v7_defconfig |    3 +++
>  2 files changed, 4 insertions(+), 1 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
