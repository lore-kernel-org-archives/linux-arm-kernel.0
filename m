From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 4 Feb 2011 14:11:36 +0100
Subject: [rtc-linux] [PATCH 00/20] world-writable files in sysfs and
	debugfs
In-Reply-To: <cover.1296818921.git.segoon@openwall.com>
References: <cover.1296818921.git.segoon@openwall.com>
Message-ID: <AANLkTik9FkP==O7athEugN4gLrnh7qyg_pPRR3MZ0La7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/4 Vasiliy Kulikov <segoon@openwall.com>:

> The search was made with trivial shell commands:
>
> find | xargs grep S_IWUGO
> find | xargs grep S_IWOTH

We only use our debugfs entries as root so it shouldn't matter much, this
is way better, thanks for fixing.

> ?mach-ux500: mbox-db5500: world-writable sysfs fifo file
> ?mfd: ab3100: world-writable debugfs *_priv files
> ?mfd: ab3500: world-writable debugfs register-* files
> ?mfd: ab8500: world-writable debugfs register-* files

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

For these.

Yours,
Linus Walleij
