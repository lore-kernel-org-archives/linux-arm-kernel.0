From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Nov 2014 14:48:31 +0100
Subject: [PATCH v3 2/3] pinctrl: add driver for Amlogic Meson SoCs
In-Reply-To: <1416168856-12747-3-git-send-email-b.galvani@gmail.com>
References: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
 <1416168856-12747-3-git-send-email-b.galvani@gmail.com>
Message-ID: <CACRpkda-U5OuKdBVGJ8UWprJkAtmTL1m11+AbNskVULPfyS72A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 9:14 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> This is a driver for the pinmux and GPIO controller available in
> Amlogic Meson SoCs. At the moment it only supports Meson8 devices,
> however other SoC families like Meson6 and Meson8b (the Cortex-A5
> variant) appear to be similar, with just different sets of banks and
> registers.
>
> GPIO interrupts are not supported at the moment due to lack of
> documentation.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

This is dependent on S?ren's patches I guess?

OK I'll merge this once we have that other code sorted out.

Yours,
Linus Walleij
