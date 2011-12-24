From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 25 Dec 2011 00:22:00 +0100
Subject: [PATCH 20/20] ARM: big removal of now unused arch_reset()
In-Reply-To: <1324288069-21940-21-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-21-git-send-email-nico@fluxnic.net>
Message-ID: <CACRpkdYMPEs8B5AaJMW0KA4t+Ky50zgB+RbrvofitUyUNskX2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 10:47 AM, Nicolas Pitre <nico@fluxnic.net> wrote:

> When this is the only content remaining in mach/system.h then the
> whole file is removed.

Merry christmas!

> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>
> ?arch/arm/mach-integrator/include/mach/system.h | ? 33 ------------------------
> ?arch/arm/mach-nomadik/include/mach/system.h ? ?| ? 32 -----------------------
> ?arch/arm/mach-u300/include/mach/system.h ? ? ? | ? 14 ----------
> ?arch/arm/mach-ux500/include/mach/system.h ? ? ?| ? 20 --------------

Acked-by:
Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
