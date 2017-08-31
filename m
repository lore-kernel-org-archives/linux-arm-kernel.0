From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 15:52:39 +0200
Subject: [PATCH] Revert "pinctrl: sunxi: Don't enforce bias disable (for
 now)"
In-Reply-To: <20170827125523.29208-1-plaes@plaes.org>
References: <20170827125523.29208-1-plaes@plaes.org>
Message-ID: <CACRpkdbNexCr-o1YozD4OaTivptV+W+ow8LpL7m5z+qvVvVP+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 27, 2017 at 2:55 PM, Priit Laes <plaes@plaes.org> wrote:

> This reverts commit 2154d94b40ea2a5de05245521371d0461bb0d669.
>
> The original patch was intented to avoid some issues with the sunxi
> gpio rework and was supposed to be reverted after all the required
> DT bits had been merged around v4.10.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
