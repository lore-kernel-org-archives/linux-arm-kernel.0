From: liu.h.jason@gmail.com (Jason Liu)
Date: Tue, 9 Aug 2011 13:05:30 +0800
Subject: [PATCH] imx5: not include the unused head file
In-Reply-To: <1312459071-6617-1-git-send-email-jason.hui@linaro.org>
References: <1312459071-6617-1-git-send-email-jason.hui@linaro.org>
Message-ID: <CAB4PhKc2TGgKXexn1b4iu4K=WoVG80iKgk8Zzd2NKroPFJvxKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sascha

2011/8/4 Jason Liu <jason.hui@linaro.org>:
> Remove the useless <asm/irq.h> and <linux/irq.h> reference
>
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ?arch/arm/mach-mx5/board-cpuimx51.c ? ? ? ? ? | ? ?2 --
> ?arch/arm/mach-mx5/board-cpuimx51sd.c ? ? ? ? | ? ?2 --
> ?arch/arm/mach-mx5/board-mx51_babbage.c ? ? ? | ? ?1 -
> ?arch/arm/mach-mx5/board-mx51_efikamx.c ? ? ? | ? ?1 -
> ?arch/arm/mach-mx5/board-mx51_efikasb.c ? ? ? | ? ?1 -
> ?arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c | ? ?1 -
> ?arch/arm/mach-mx5/mx51_efika.c ? ? ? ? ? ? ? | ? ?1 -
> ?7 files changed, 0 insertions(+), 9 deletions(-)
>

Any feedback about this patch?

Jason
