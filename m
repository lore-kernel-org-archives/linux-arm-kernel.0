From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Jun 2017 16:25:39 -0500
Subject: [PATCH v2 2/3] dt-bindings: iio: update STM32 timers clock names
In-Reply-To: <1497453196-31470-3-git-send-email-fabrice.gasnier@st.com>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
 <1497453196-31470-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170622212539.l3yblwqurahdvlqq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 05:13:15PM +0200, Fabrice Gasnier wrote:
> Clock name has been updated during driver/DT binding review:
> https://lkml.org/lkml/2016/12/13/718
> Update DT binding doc to reflect this.
> 
> Fixes: bf2d8581b1b3 (iio: Add bindings for STM32 timer trigger driver)
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
