From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Jun 2017 16:04:14 -0500
Subject: [PATCH v2 1/5] dt-bindings: i2c-stm32: Document the STM32F7 I2C
 bindings
In-Reply-To: <1497958890-5530-2-git-send-email-pierre-yves.mordret@st.com>
References: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
 <1497958890-5530-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170622210414.n6vdsc2ga2dwdvyd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 01:41:26PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the documentation of device tree bindings for STM32F7 I2C
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
> Change in V2
>   * Remove i2c-timing binding in order to use generic bindings SCL Rising
>     and Falling time instead
> ---
>  .../devicetree/bindings/i2c/i2c-stm32.txt          | 29 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
