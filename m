From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 28 Mar 2018 00:57:58 +0200
Subject: [RESEND PATCH 0/3] Add pwm-cells on STM32 LPTimer
In-Reply-To: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180327225757.GK28163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 02:36:02PM +0100, Fabrice Gasnier wrote:
> Add missing generic #pwm-cells on STM32 LPTimer to allow initialization
> of channel, period and polarity.
> 
> Fabrice Gasnier (1):
>   ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743
> 
> Gerald Baeza (2):
>   dt-bindings: pwm-stm32-lp: add #pwm-cells
>   pwm: stm32: LPTimer: use 3 cells xlate
> 
>  Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
>  arch/arm/boot/dts/stm32h743.dtsi                       | 5 +++++
>  drivers/pwm/pwm-stm32-lp.c                             | 2 ++
>  3 files changed, 10 insertions(+)

Applied patches 1 and 2, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/31b58c51/attachment.sig>
