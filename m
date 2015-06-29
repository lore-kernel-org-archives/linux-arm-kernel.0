From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jun 2015 12:53:04 +0200
Subject: [PATCH RFC 0/4] PL08x DT bindings and LPC18xx DMA support
In-Reply-To: <1434280937-8369-1-git-send-email-manabian@gmail.com>
References: <1434280937-8369-1-git-send-email-manabian@gmail.com>
Message-ID: <CACRpkdZZBGzioO25-Sov0CVK8JuRp1uuJDEZKFtLxg9WwsSzww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 14, 2015 at 1:22 PM, Joachim Eastwood <manabian@gmail.com> wrote:

> This patch set aims to add support for DMA on the NXP LPC18xx/43xx
> (Cortex-M3/M4) platform. The platform has a PL080 controller with a
> mux in front of the DMA request lines. This setup is quite common
> and can be found on most other, if not all, NXP LPC devices.

Nice!

>  - remove channel sub-nodes from driver and dt doc.

Why? It was a good approach for the Nomadik. Well I'll look
how you do it for NXP, I guess it makes total sense for you.

N?ras,
Linus Walleij
