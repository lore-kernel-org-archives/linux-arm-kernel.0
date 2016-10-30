From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:28 -0500
Subject: [PATCH 5/5] irqchip: st: Remove obsolete platforms from dt
 binding doc
In-Reply-To: <1477065443-10668-6-git-send-email-patrice.chotard@st.com>
References: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
 <1477065443-10668-6-git-send-email-patrice.chotard@st.com>
Message-ID: <20161030204128.gykqvspj72oednox@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 05:57:23PM +0200, patrice.chotard at st.com wrote:
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

Acked-by: Rob Herring <robh@kernel.org>
