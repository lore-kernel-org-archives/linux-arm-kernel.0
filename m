From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jun 2016 09:26:55 +0200
Subject: [PATCH v2 1/9] pinctrl: walk into bcm subdir unconditionally
In-Reply-To: <1464934708-24769-2-git-send-email-kraxel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-2-git-send-email-kraxel@redhat.com>
Message-ID: <CACRpkdZ+RnCo=GhsRrY0+VxLYcETrUZZGrbH-O3rwO7rRSG-ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 8:18 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:

> There is no ARCH_BCM on arm64, and we need pinctrl-bcm2835 for the rpi3.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

I see I got an identical patch from Florian Fainelli and applied it.
Sorry for my clashes, confusion and screwups... Added Eric's
ACK on the applied patch.

Yours,
Linus Walleij
