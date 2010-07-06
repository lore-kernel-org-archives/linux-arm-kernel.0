From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 06 Jul 2010 09:47:37 -0700
Subject: [PATCH v2] msm: gpio: Add set_wake support to msm7200a-gpio's
	irq_chip.
In-Reply-To: <1278185128-29161-1-git-send-email-gbean@codeaurora.org>
References: <1278185128-29161-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1278434857.27490.2.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-07-03 at 12:25 -0700, Gregory Bean wrote:
> Add power-management and irq_chip hooks to allow configuration
> of msm-gpio irq lines as wakeup sources.
> 

What level of correlation is there between power management and the wake
up hooks? Just irq_masks ?

Daniel
