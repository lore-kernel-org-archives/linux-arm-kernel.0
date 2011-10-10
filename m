From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 03:43:57 +0200
Subject: [PATCH 9/9] ARM: SPMP8000: Add Kconfig and Makefile entries to
	build the machine
In-Reply-To: <1318178172-7965-10-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-10-git-send-email-zoss@devai.org>
Message-ID: <CAKnu2Mq+9GwJSPXUtcsYGH2dQ4TbzBcpAWG3vze4thBNp1oW7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/9 Zoltan Devai <zoss@devai.org>:

> +config ARCH_SPMP8000
> + ? ? ? bool "Sunplus SPMP8000"
> + ? ? ? select CPU_ARM926T
> + ? ? ? select ARM_VIC

It's quite common for ARM926EJ-S systems to have TCM,
if you don't know whether your system has it just try
select HAVE_TCM for fun and see if it is detected on boot.

Yours,
Linus Walleij
