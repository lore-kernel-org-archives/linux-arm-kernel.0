From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Aug 2014 14:22:01 +0200
Subject: [PATCH V6 0/3] gpio: Add APM X-Gene SoC platform GPIO driver
In-Reply-To: <1406833407-28316-1-git-send-email-fkan@apm.com>
References: <1406833407-28316-1-git-send-email-fkan@apm.com>
Message-ID: <CACRpkdZ79W9wjJ-AdtMqju6EBcTd+TEdUja6XPxfJT04zrDjDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 9:03 PM, Feng Kan <fkan@apm.com> wrote:

> This patch add the GPIO controller in the APM X-Gene platform. The GPIO
> controller pins are muxed with the generic flash controller pins on the
> system.
>
> V6 Change:
>         1. change attribute description of second cell in gpio dts node
>            under documentation.

Patches 1+2 applied to the GPIO tree.

Patch 3 need to go through whatever tree handles this platform,
but you can add my ACK.

Yours,
Linus Walleij
