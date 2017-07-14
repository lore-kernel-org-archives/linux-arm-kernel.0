From: robh@kernel.org (Rob Herring)
Date: Fri, 14 Jul 2017 09:41:39 -0500
Subject: [PATCH 1/4] dt-bindings: iio: stm32-dac: add support for STM32F4
In-Reply-To: <1499693040-12994-2-git-send-email-fabrice.gasnier@st.com>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
 <1499693040-12994-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170714144139.n7qqqmtvjyfysrwj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 03:23:57PM +0200, Fabrice Gasnier wrote:
> Introduce new compatible to support STM32F4 DAC (Digital-To-Analog
> converter) variant.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
