From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 17:37:59 -0600
Subject: [PATCH v2 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
In-Reply-To: <20181108090502.14543-2-benjamin.gaignard@st.com>
References: <20181108090502.14543-1-benjamin.gaignard@st.com>
 <20181108090502.14543-2-benjamin.gaignard@st.com>
Message-ID: <5bea0ed9.1c69fb81.bd59a.4fdc@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  8 Nov 2018 10:04:59 +0100, Benjamin Gaignard wrote:
> Add bindings for STM32 hardware spinlock device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2 :
> - change clock name from hwspinlock to hsem to be align with hardware
>   documentation
> 
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
