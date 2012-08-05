From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 11:47:21 +0200
Subject: [PATCH 2/4] gpio/mxc: specify gpio base for device tree probe
In-Reply-To: <1344146488-9496-2-git-send-email-shawn.guo@linaro.org>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
 <1344146488-9496-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdZFmfb-Fg_K1UPyx5Qw1XkODNo4aiNiOkoSXyOYRGMZ7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 8:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Currently, unlike the non-DT probe where the gpio base is specified
> with pdev->id, the DT probe uses the base dynamically allocated by
> gpio core, which uses a completely different numbering scheme.  This
> causes two issues to user space applications which access sysfs entry
> /sys/class/gpio/gpioN.

Applied.

Thanks,
Linus Walleij
