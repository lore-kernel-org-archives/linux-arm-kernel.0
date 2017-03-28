From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Mar 2017 11:31:38 +0200
Subject: [RFT PATCH 6/6] ARM64: dts: meson-gxbb: Add USB Hub GPIO hog
In-Reply-To: <1490286449-19448-7-git-send-email-narmstrong@baylibre.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
 <1490286449-19448-7-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdafNk0921by3kGYqEc88P5FKxepXZsvenGELzpf=Q4AnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 5:27 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> The ODroid-C2 on-board USB Hub needs to to have it's reset signal set to
> high level in order to be enumerated by the USB Host Controller.
>
> But this management must be part of the currently in-development Generic
> Power Sequence patch that will allow a USB Controller driver to start and stop
> a power sequence associated to the USB Bus.
>
> In the meantime, a simple USB Hog will work to enable the USB Hub.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
