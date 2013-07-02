From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jul 2013 22:19:36 +0200
Subject: [PATCH v4] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
References: <1372332203-30228-1-git-send-email-jonas.jensen@gmail.com>
 <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACRpkdbT3yiq79rCRK0kFe39Y6QkSZHJ+7kbcmKFH8esGEN3LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 4:02 PM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> This patch adds an clocksource driver for the main timer(s)
> found on MOXA ART SoCs.
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

I'm pretty happy with this version, tglx points out a possible optimization
getting rid of some unnecessary reads in hotpath but anyway:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
