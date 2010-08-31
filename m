From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 31 Aug 2010 09:50:18 -0700
Subject: [PATCH 1/2] msm: Install the Google-Android gpio driver.
In-Reply-To: <1283213906-17671-1-git-send-email-gbean@codeaurora.org>
References: <1283213906-17671-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1283273418.11790.3.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-30 at 17:18 -0700, Gregory Bean wrote:
> +                       /* printk("%s %08x %08x bit %d gpio %d irq %d\n",
> +                               __func__, v, m, j, msm_chip->chip.start + j,
> +                               FIRST_GPIO_IRQ + msm_chip->chip.start + j); */
> 

Can you drop everything that's un-used .. There's also the enter/exit
sleep functions, which I'm pretty sure aren't used. Also break this into
two patches one for gpio and another for the interrupt component ..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
