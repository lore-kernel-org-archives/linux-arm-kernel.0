From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Mon, 28 Jan 2013 20:16:35 +0900
Subject: [PATCH v2] ARM: versatile: fix the PCI IRQ regression
In-Reply-To: <1359328750-28046-1-git-send-email-linus.walleij@linaro.org>
References: <1359328750-28046-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201301282016.BAG95395.VMOFFFQSHLOtJO@I-love.SAKURA.ne.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> ---
> ChangeLog v1->v2:
> - Got the PIC/SIC valid mask wrong again, take a deep breath
>   and use the foolproof method of defining each bit so that
>   nobody will get caught by this again. Didn't see this first
>   because the SCSI layer takes for ever to time out.
> ---
>  arch/arm/mach-versatile/core.c | 15 ++++++++++++++-
>  arch/arm/mach-versatile/pci.c  | 11 ++++++-----
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 

This patch fixes my problem. Please send to 3.8. Thank you!
