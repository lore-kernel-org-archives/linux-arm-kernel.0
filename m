From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Mar 2017 09:37:32 -0500
Subject: [PATCH v3 04/11] IIO: add DT bindings for stm32 DFSDM filter
In-Reply-To: <1489759704-30217-5-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-5-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20170324143732.nvq2wfra6q3hcrhs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 03:08:17PM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes Digital Filter for Sigma Delta
> Modulators. DFSDM allows to connect sigma delta
> modulators.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2->V3:
>    Fixes based on V2 comments
> 
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 120 +++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt

Acked-by: Rob Herring <robh@kernel.org>
