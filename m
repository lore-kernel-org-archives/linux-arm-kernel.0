From: robh@kernel.org (Rob Herring)
Date: Tue, 16 Oct 2018 17:36:31 -0500
Subject: [PATCH 1/2] dt-bindings: spi: add stm32 qspi controller
In-Reply-To: <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
References: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
 <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
Message-ID: <20181016223631.GA19725@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Oct 2018 09:43:02 +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds the documentation of device tree bindings
> for the STM32 QSPI controller. It is a specialized communication
> interface targeting single, dual or quad SPI Flash memories (NOR/NAND).
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
