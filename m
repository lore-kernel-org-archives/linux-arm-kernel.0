From: robh@kernel.org (Rob Herring)
Date: Fri, 10 Nov 2017 15:05:51 -0600
Subject: [PATCH v4 06/12] IIO: add DT bindings for stm32 DFSDM filter
In-Reply-To: <1510222354-15290-7-git-send-email-arnaud.pouliquen@st.com>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
 <1510222354-15290-7-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20171110210551.dpt3x2rsqnsk3yzi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 11:12:28AM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes STM32 Digital Filter for Sigma Delta
> Modulators. DFSDM allows to connect sigma delta
> modulators.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V3->V4 changes:
>    V3 Acked-by Rob Herring but add some minor changes:
> 	- rename compatibility to st,stm32h7-dfsdm
> 	- update example to align with last clock patches upstreamed
> 	- replace pdm by dmic in example
> 
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt

Acked-by: Rob Herring <robh@kernel.org>
