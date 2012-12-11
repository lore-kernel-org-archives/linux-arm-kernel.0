From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 10:18:56 +0100
Subject: [PATCH 10/12] ARM: ux500: Setup correct settling time for the
 MMCI regulator
In-Reply-To: <1355129761-8088-11-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-11-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb7s+KHYtaZLAKxLod4o=B5sRtdp091qfgqjBDgrhc9ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 9:55 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The GPIO controlled MMCI regulator used on the ux5x0 boards takes
> 100us to settle. There's already a binding to provide such
> information. Let's make use of it.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
