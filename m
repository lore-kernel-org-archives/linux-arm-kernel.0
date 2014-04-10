From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 19:29:26 +0200
Subject: [PATCH 0/5] GPIO OMAP driver changes for v3.16
In-Reply-To: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CACRpkdarYt4tAD9WMDu6Me+dhipVyDHMpgF-AQ8SDNKMmhSjsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 6, 2014 at 4:58 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> Now that you have sent your changes for v3.15 to Torvalds, here are some
> changes for the OMAP GPIO driver targeted to v3.16. Mostly improvements
> so nothing here is -rc material.

I like this series so I have applied them for v3.16, pending some ACK
from Kevin &| Santosh.

> The biggest change is Patch 4 that converts the driver to use the newly
> introduced generic irqchip helpers in the gpiolib core which allows to
> remove some driver specific logic that should really be generic.

Excellent, I will take a closer look at this, it seems there is some
cruft still in but let me look.

Yours,
Linus Walleij
