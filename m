From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Jun 2017 16:25:57 -0500
Subject: [PATCH v2 3/3] dt-bindings: pwm: update STM32 timers clock names
In-Reply-To: <1497453196-31470-4-git-send-email-fabrice.gasnier@st.com>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
 <1497453196-31470-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170622212557.vwojcyil5sg2jpsg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 05:13:16PM +0200, Fabrice Gasnier wrote:
> Clock name has been updated during driver/DT binding review:
> https://lkml.org/lkml/2016/12/13/718
> Update DT binding doc to reflect this.
> 
> Fixes: cd9a99c2f8e8 (dt-bindings: pwm: Add STM32 bindings)
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
