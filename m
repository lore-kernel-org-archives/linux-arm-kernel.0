From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 03:32:07 +0200
Subject: [PATCH 5/9] ARM: SPMP8000: Add pinmux driver
In-Reply-To: <1318178172-7965-6-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-6-git-send-email-zoss@devai.org>
Message-ID: <CAKnu2MrXWoOka9D++q3h-KfgyYRhGA81Tcf07y7VdEUszZrU9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/9 Zoltan Devai <zoss@devai.org>:

> ?arch/arm/mach-spmp8000/pinmux.c | ?131 +++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 131 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-spmp8000/pinmux.c

I'm creating this new pin control and pin mux subsystem,
set for next merge window. Can you check it out and see
if it does what you need?

http://marc.info/?l=linux-kernel&m=131805699106465&w=2

Thanks,
Linus Walleij
