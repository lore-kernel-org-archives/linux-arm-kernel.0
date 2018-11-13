From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 20:13:49 -0600
Subject: [PATCH v3 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
In-Reply-To: <20181112152342.6561-2-benjamin.gaignard@st.com>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
 <20181112152342.6561-2-benjamin.gaignard@st.com>
Message-ID: <20181113021349.GA9687@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2018 16:23:39 +0100, Benjamin Gaignard wrote:
> Add bindings for STM32 hardware spinlock device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 3 :
> - fix clock name in properties description
> version 2 :
> - change clock name from hwspinlock to hsem to be align with hardware
>   documentation
> 
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
