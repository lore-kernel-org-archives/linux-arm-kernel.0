From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Sep 2013 20:01:18 +0200
Subject: [PATCH v6] gpio: pcf857x: Add OF support
In-Reply-To: <1379788789-19801-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1379788789-19801-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CACRpkdbipy4RwrxbbB5NUO=MkZ0+gJwXHVRZMb+Mc5e6WTYiaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 8:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Add DT bindings for the pcf857x-compatible chips and parse the device
> tree node in the driver.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../devicetree/bindings/gpio/gpio-pcf857x.txt      | 71 ++++++++++++++++++++++
>  drivers/gpio/gpio-pcf857x.c                        | 44 +++++++++++---
>  2 files changed, 107 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-pcf857x.txt
>
> Changes since v5:
>
> - Renamed pin to line in the DT bindings documentation
> - Renamed pins-initial-states DT property to lines-initial-states

I can't see any problem with this so patch applied.

Yours,
Linus Walleij
