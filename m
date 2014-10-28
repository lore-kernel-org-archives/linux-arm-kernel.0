From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 15:40:17 +0100
Subject: [PATCH v2 11/53] dmaengine: coh901318: Split device_control
In-Reply-To: <1413454672-27400-12-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
 <1413454672-27400-12-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbPvJ7q54vC-suOQ4Qnk8TpWdSWpoGir8-Q2cQzgCvzRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 12:17 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Split the device_control callback of the ST-Ericsson COH901318 DMA driver to
> make use of the newly introduced callbacks, that will eventually be used to
> retrieve slave capabilities.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
