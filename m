From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Dec 2015 14:08:13 +0100
Subject: [PATCH] fixup! pinctrl: pxa: pxa2xx: add pin control skeleton
In-Reply-To: <1449956585-17118-1-git-send-email-robert.jarzmik@free.fr>
References: <1449956585-17118-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <CACRpkdZgHWwGXhSv4D9-oyS1wW_ZGDpyUfM47-EbU9ujNRD3Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2015 at 10:43 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> The wrong free functions were used to release temporary buffers.
>
> This didn't show up in the normal driver's life. Yet in suspend to RAM,
> the managed resource list is walked, and as memory was released, the
> list is corrupted and make the kernel Oops.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Linus, if it's time, then this can fixup the commit. If not, I'll
> provide a better commit message.

I just applied it on top of my branch, removing the "fixup!"
comment. It's enough of a commit message I think.

Yours,
Linus Walleij
