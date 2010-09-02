From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Sep 2010 21:45:33 +0200
Subject: [PATCH 2/3] plat-nomadik: Added suspend/resume support for MTU
	timer.
In-Reply-To: <1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
Message-ID: <AANLkTimPGgraazJogLU-YxZ5e59rik-c7UNtfi=VfkMD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/2 Jonas Aaberg <jonas.aberg@stericsson.com>:

> Acked-by: Linus Walleij <linus.walleij@stericsson.com>

... and then I saw this:

> (...)
> diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
> (...)
> +static void nmdk_timer_reset(void)
> +{
> + ? ? ? u32 cr = MTU_CRn_32BITS | MTU_CRn_ENA;
