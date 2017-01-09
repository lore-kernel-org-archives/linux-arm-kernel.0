From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jan 2017 12:01:55 -0600
Subject: [PATCH v7 3/8] PWM: add pwm-stm32 DT bindings
In-Reply-To: <1483608344-9012-4-git-send-email-benjamin.gaignard@st.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-4-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20170109180155.3invte4tko4lipcs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 10:25:39AM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
> 
> version 6:
> - change st,breakinput parameter format to make it usuable on stm32f7 too.
> 
> version 2:
> - use parameters instead of compatible of handle the hardware configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

Acked-by: Rob Herring <robh@kernel.org>
