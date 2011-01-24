From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 24 Jan 2011 14:45:42 -0800
Subject: [PATCH v2 06/11] msm: irqs-8960: Interrupt map for MSM8960
In-Reply-To: <1295468747-22796-7-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-7-git-send-email-davidb@codeaurora.org>
Message-ID: <1295909142.29639.63.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
> +#define INT_VGIC                               (GIC_PPI_START + 0)
> +#define INT_DEBUG_TIMER_EXP                    (GIC_PPI_START + 1)
> +#define INT_GP_TIMER_EXP                       (GIC_PPI_START + 2)
> +#define INT_GP_TIMER2_EXP                      (GIC_PPI_START + 3)
> +#define WDT0_ACCSCSSNBARK_INT                  (GIC_PPI_START + 4)
> +#define WDT1_ACCSCSSNBARK_INT                  (GIC_PPI_START + 5)
> +#define AVS_SVICINT                            (GIC_PPI_START + 6)
> +#define AVS_SVICINTSWDONE                      (GIC_PPI_START + 7)
> +#define CPU_DBGCPUXCOMMRXFULL                  (GIC_PPI_START + 8)
> +#define CPU_DBGCPUXCOMMTXEMPTY                 (GIC_PPI_START + 9)
> +#define CPU_SICCPUXPERFMONIRPTREQ              (GIC_PPI_START + 10)
> +#define SC_AVSCPUXDOWN                         (GIC_PPI_START + 11)
> +#define SC_AVSCPUXUP                           (GIC_PPI_START + 12)
> +#define SC_SICCPUXACGIRPTREQ                   (GIC_PPI_START + 13)
> +#define SC_SICCPUXEXTFAULTIRPTREQ              (GIC_PPI_START + 14)
> +/* PPI 15 is unused */ 

How are you handling this at runtime?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
