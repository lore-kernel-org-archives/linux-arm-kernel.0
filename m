From: robh@kernel.org (Rob Herring)
Date: Fri, 14 Jul 2017 20:29:29 -0500
Subject: [PATCH 1/3] dt-bindings: regulator: Add STM32 Voltage Reference
 Buffer
In-Reply-To: <1499776233-29116-2-git-send-email-fabrice.gasnier@st.com>
References: <1499776233-29116-1-git-send-email-fabrice.gasnier@st.com>
 <1499776233-29116-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170715012929.ofmd3yxi6iv2bkbs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 02:30:31PM +0200, Fabrice Gasnier wrote:
> Document STM32 VREFBUF (voltage reference buffer) which can be used as
> voltage reference for ADCs, DACs and external components.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../bindings/regulator/st,stm32-vrefbuf.txt          | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt

Acked-by: Rob Herring <robh@kernel.org>
