From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jul 2012 13:03:00 +0200
Subject: [PATCH 2/2] gpio/omap: add *remove* callback in platform_driver
In-Reply-To: <87394xhocn.fsf@ti.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
 <1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
 <87394xhocn.fsf@ti.com>
Message-ID: <CACRpkdZMG_ZHW_eGGrdrJh1SuO_=hOObijzmxG1ob6RoNf_dwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 1:25 AM, Kevin Hilman <khilman@ti.com> wrote:

> There is quite a bit of other things to do in remove to properly cleanup
> what is done in probe.

OK I'm dropping this patch for now...

Yours,
Linus Walleij
