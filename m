From: davidb@codeaurora.org (David Brown)
Date: Wed, 21 Sep 2011 13:22:02 -0700
Subject: [PATCH 49/57] video: irq: Remove IRQF_DISABLED
In-Reply-To: <1316597339-29861-50-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-50-git-send-email-yong.zhang0@gmail.com>
Message-ID: <20110921202202.GB2321@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 05:28:50PM +0800, Yong Zhang wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> ---
>  drivers/video/msm/mddi.c                  |    2 +-
>  drivers/video/msm/mdp.c                   |    2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
