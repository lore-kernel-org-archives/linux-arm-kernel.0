From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Mar 2018 17:53:56 -0600
Subject: [PATCH v2 01/12] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
In-Reply-To: <1520528045-18330-2-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
 <1520528045-18330-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20180309235356.qd2wx6teeuxkwwjz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 05:53:54PM +0100, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> The RCC block is responsible of the management of the clock and reset
> generation for the complete circuit.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
