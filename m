From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 15:22:15 -0500
Subject: [PATCH v3 1/2] dt-bindings: iio: stm32-dac: Add support for
 STM32 DAC
In-Reply-To: <1491839390-2449-2-git-send-email-fabrice.gasnier@st.com>
References: <1491839390-2449-1-git-send-email-fabrice.gasnier@st.com>
 <1491839390-2449-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170413202215.4ka4ca57kx2ttbzl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 05:49:49PM +0200, Fabrice Gasnier wrote:
> Document STMicroelectronics STM32 DAC (digital-to-analog converter).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - use 'reg' instead of 'st,dac-channel' property
> - remove alignment from description
> ---
>  .../devicetree/bindings/iio/dac/st,stm32-dac.txt   | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt

Acked-by: Rob Herring <robh@kernel.org>
