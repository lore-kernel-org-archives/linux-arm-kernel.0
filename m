From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Sep 2017 18:39:34 -0500
Subject: [PATCH] dt-bindings: clk: stm32h7: fix clock-cell size
In-Reply-To: <1505821446-6847-1-git-send-email-gabriel.fernandez@st.com>
References: <1505821446-6847-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170921233934.syq5onkdwtikvyso@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 01:44:06PM +0200, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> The clock-cell size is 1 on stm32h7 plaform.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Fixes: 3e4d618b0722 ("clk: stm32h7: Add stm32h743 clock driver")
> ---
>  Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
