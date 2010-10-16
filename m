From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 16 Oct 2010 18:10:13 +0200
Subject: [PATCH RFC] arm: genirq: fix boot on arm platforms
In-Reply-To: <1287077397-21781-1-git-send-email-gadiyar@ti.com>
References: <1287077397-21781-1-git-send-email-gadiyar@ti.com>
Message-ID: <AANLkTin3Z+x0pxrDg4vAa5Wuahc3uGC=ve7=3mHE6KBC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/14 Anand Gadiyar <gadiyar@ti.com>:

> We seem to be using desc->status without assigning desc to
> anything. Fix this by adding back the code that was originally
> there.
>
> I'm not 100% sure this is the correct fix. I'm just reporting
> that this small change allows me to boot again.

Thank you for this patch Anand, it makes my
ARM RealView PB1176 and my ST-Ericsson U8500 prototype
both boot again on the -next tree!

Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
