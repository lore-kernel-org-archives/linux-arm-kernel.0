From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Thu, 14 Nov 2013 10:36:39 +0000
Subject: [PATCH 0/2] Fixes for STi SOCs
In-Reply-To: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
References: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <5284A7B7.4070406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

I think, these patches some how missed 3.13 window.
Can you please consider these fixes at least for 3.13-rc1?

Without these patches we can not get the serial output with
multi_v7_defconfig on STi SOCs.


Thanks,
srini

On 17/09/13 10:26, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> Hi Arnd/Olof, 
> 
> These two are very minor fixes for STi SOCs.
> One of the fix is a typo and other is to add two new options to
> multi_v7_defconfig to get STi SOC based boards boot with nfs root with serial
> console.
> 
> These patches are based on v3.12-rc1.
> 
> Thanks,
> srini
> 
> Srinivas Kandagatla (2):
>   ARM: STi: OF: Fix a typo in pincfg header
>   ARM: multi_v7_defconfig: Fix STi support
> 
>  arch/arm/boot/dts/st-pincfg.h       |    2 +-
>  arch/arm/configs/multi_v7_defconfig |    3 +++
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
