From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 27 Aug 2010 13:30:08 -0700
Subject: [PATCH 1/5 v3] msm: add gpiomux api for gpio multiplex &
	configuration.
In-Reply-To: <1282925975-26367-1-git-send-email-gbean@codeaurora.org>
References: <1282925975-26367-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1282941008.5075.26.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-08-27 at 09:19 -0700, Gregory Bean wrote:
> +obj-y += gpiomux.o
> +obj-$(CONFIG_ARCH_MSM7X30) += gpiomux-7x30.o gpiomux-7x00.o
> +obj-$(CONFIG_ARCH_QSD8X50) += gpiomux-8x50.o gpiomux-7x00.o
> +obj-$(CONFIG_ARCH_MSM8X60) += gpiomux-8x60.o 

Is this right? I got a built failure before 7x00 isn't in the list..

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
