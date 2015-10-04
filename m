From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sun, 4 Oct 2015 10:27:02 +0200
Subject: [PATCH 1/3] dt-bindings: Document the STM32 HW RNG bindings
In-Reply-To: <1443904519-24012-2-git-send-email-daniel.thompson@linaro.org>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
 <1443904519-24012-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <5610E2D6.2050205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 10/03/2015 10:35 PM, Daniel Thompson wrote:
> This adds documenttaion of device tree binds for the STM32 hardware
s/documenttaion/documentation/
> random number generator.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>   .../devicetree/bindings/hwrng/stm32-rng.txt         | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwrng/stm32-rng.txt

Except the typo, the patch looks good to me.
When fixed, you can add my:
Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks!
Maxime
