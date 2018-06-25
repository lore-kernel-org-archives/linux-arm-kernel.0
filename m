From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 09:51:30 -0600
Subject: [PATCH V4 1/4] dt-bindings: watchdog: add stm32mp1 support
In-Reply-To: <1529571737-3552-2-git-send-email-ludovic.Barre@st.com>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-2-git-send-email-ludovic.Barre@st.com>
Message-ID: <20180625155130.GA25449@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 11:02:14AM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds support of stm32mp1.
> stm32mp1 requires 2 clocks lsi and pclk.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt          | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
