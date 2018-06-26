From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Jun 2018 14:39:39 -0600
Subject: [PATCH V5 1/5] dt-bindings: watchdog: add stm32mp1 support
In-Reply-To: <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
Message-ID: <20180626203939.GA17242@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 05:42:59PM +0200, Ludovic Barre wrote:
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
