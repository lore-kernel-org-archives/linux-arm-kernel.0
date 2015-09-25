From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Sep 2015 10:03:24 -0700
Subject: [PATCH v4 16/22] pinctrl: Probe pinctrl devices on demand
In-Reply-To: <1441628627-5143-17-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-17-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CACRpkdZR0Sv+Fdka7rfSjbZj4enm97mpZppQvap8ZrNDo1dzLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 7, 2015 at 5:23 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:

> When looking up a pin controller through its OF node, probe it if it
> hasn't already.
>
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
