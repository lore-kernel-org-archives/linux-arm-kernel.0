From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 31 Oct 2016 09:06:38 +0000
Subject: [PATCH 5/5] irqchip: st: Remove obsolete platforms from dt
 binding doc
In-Reply-To: <1477065443-10668-6-git-send-email-patrice.chotard@st.com>
References: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
 <1477065443-10668-6-git-send-email-patrice.chotard@st.com>
Message-ID: <20161031090638.GA16442@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016, patrice.chotard at st.com wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
> 
> STiH415/6 SoC support is being removed from the kernel.
> This patch updates the sti irchip and removes
> references to these obsolete platforms.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Cc: <tglx@linutronix.de>
> Cc: <jason@lakedaemon.net>
> Cc: <marc.zyngier@arm.com>
> ---
>  .../devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt  | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Peter Griffin <peter.griffin@linaro.org>
