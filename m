From: davidb@codeaurora.org (David Brown)
Date: Wed, 15 May 2013 10:12:06 -0700
Subject: [PATCH 14/20] ARM: msm: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-15-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-15-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130515171206.GA3799@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 05:38:47PM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for msm as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-msm/board-dt-8660.c | 2 --
>  arch/arm/mach-msm/board-dt-8960.c | 2 --
>  2 files changed, 4 deletions(-)

I've replaced the patch in my msm-cleanup tree with this one.  I'll
push this out once the support goes into the arm soc tree.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
