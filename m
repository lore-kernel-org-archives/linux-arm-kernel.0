From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 27 Jan 2011 16:15:13 +0300
Subject: some i.MX23/28 patches
In-Reply-To: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
References: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4D416FE1.3010409@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-01-2011 14:40, Sascha Hauer wrote:

> The following contains some i.MX23/28 cleanup patches.

> Sascha

> The following changes since commit 376e9c5848abef8c72c09bd89f2f7ee128caa104:

>    ARM: mxs: add initial pm support (2011-01-26 08:30:49 +0100)

> are available in the git repository at:
>    none ..BRANCH.NOT.VERIFIED..

    Forgot to push?

> Sascha Hauer (4):
>        ARM i.MX23/28: deobfuscate gpio initialization
>        ARM i.MX23/28: do not use complicated macros if not necessary
>        ARM i.MX23: remove reserved register defines
>        ARM i.MX28: remove reserved register defines
>
>   arch/arm/mach-mxs/gpio.c              |   45 +++++----
>   arch/arm/mach-mxs/regs-clkctrl-mx23.h |  124 -----------------------
>   arch/arm/mach-mxs/regs-clkctrl-mx28.h |  177 ---------------------------------
>   3 files changed, 24 insertions(+), 322 deletions(-)

WBR, Sergei
