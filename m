From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 11:10:09 -0500
Subject: [PATCH v4 1/5] dt-bindings: watchdog: Document STM32 IWDG bindings
In-Reply-To: <1490886926-20585-2-git-send-email-yannick.fertre@st.com>
References: <1490886926-20585-1-git-send-email-yannick.fertre@st.com>
 <1490886926-20585-2-git-send-email-yannick.fertre@st.com>
Message-ID: <20170403161009.zkddbn4elfakbqnq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 05:15:22PM +0200, Yannick Fertre wrote:
> This adds documentation of device tree bindings for the STM32 IWDG
> (Independent WatchDoG).
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> 
> Author:    Yannick Fertre <yannick.fertre@st.com>

This shouldn't be here.

> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt

Otherwise,

Acked-by: Rob Herring <robh@kernel.org> 
