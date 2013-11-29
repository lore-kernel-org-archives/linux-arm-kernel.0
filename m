From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 08:47:55 +0100
Subject: [PATCH v6 0/6] gpio: daVinci: cleanup and feature enhancement
In-Reply-To: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <CACRpkdYvNwF+dxfiLCHpCL+Ze17PMAMkJo4s-4T4ku1KxDPXxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 7:15 PM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:

> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>
> This patch series does the following
> 1> Ports the driver to use irqdomain.
> 2> Adds dt binding support for gpio-davinci.
> 3> Adds DA850 dt support goio.
>
> Changes for v6:
> 1: GPIO driver now migrated to irq domain legacy.
> 2: Fixed review comments pointed by Grygorii.
> 3: Included Ack's.

This series is looking nice, I assume that Sekhar will take this through
the DaVinci tree once he's happy with it. I think I've ACKed all relevant
patches, else tell me.

Yours,
Linus Walleij
