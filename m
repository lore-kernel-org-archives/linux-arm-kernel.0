From: robh@kernel.org (Rob Herring)
Date: Fri, 7 Jul 2017 08:41:01 -0500
Subject: [PATCH v3 1/5] dt-bindings: i2c-stm32: Document the STM32F7 I2C
 bindings
In-Reply-To: <1499356386-28779-2-git-send-email-pierre-yves.mordret@st.com>
References: <1499356386-28779-1-git-send-email-pierre-yves.mordret@st.com>
 <1499356386-28779-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170707134101.pm6cni7mjefi56iv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 05:53:02PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the documentation of device tree bindings for STM32F7 I2C
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v3:
>         * None
>     v2:
>         * Remove i2c-timing binding in order to use generic bindings SCL
>           Rising and Falling time instead
> ---
> ---
>  .../devicetree/bindings/i2c/i2c-stm32.txt          | 29 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

I acked v2. Please add acks when posting new versions.

Rob
