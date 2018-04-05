From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Thu, 5 Apr 2018 21:11:37 +0200
Subject: [v2] ARM: dts: qcom: Add apq8064 Dragon Board 600c support
In-Reply-To: <20180316215436.22906-1-srinivas.kandagatla@linaro.org>
References: <20180316215436.22906-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180405191137.GA17656@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 09:54:36PM +0000, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add support to DB600c board, which is another
> 96boards based on Qualcomm APQ8064 SoC.
> 
> Support for USB, HDMI, PCIe, I2C, SPI, eMMC, microSD card, LEDs
> device tree nodes is added in this patch.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
> 	- added chosen node with stdout, suggested by Stephen Boyd
> 	- removed spi flash node and gpio22 pinconf, as its not required in this patch.
> 	- removed extra comment lines and fix a node name, spotted by Stephen Boyd.
> 
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/qcom-apq8064-db600c.dts | 530 ++++++++++++++++++++++++++++++
>  2 files changed, 531 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8064-db600c.dts

Hello Srini (I hope you had a nice vacation!)


Running checkpatch on this patch gives a few of these warnings:

WARNING: line over 80 characters

These can probably be ignored, since they exist for most
arch/arm/boot/dts/qcom-*.dts files.


However, it also gives a few of these errors:

ERROR: trailing whitespace

These should probably be fixed, since the are errors and not warnings.


Kind regards,
Niklas
