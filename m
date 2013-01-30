From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Jan 2013 19:08:51 +0100
Subject: [PATCH 1/1] pinctrl: nomadik: Rename Device Tree compatible string
In-Reply-To: <20130130170750.GA5217@gmail.com>
References: <1359563102-5934-1-git-send-email-linus.walleij@stericsson.com>
 <51094E50.4000302@wwwdotorg.org> <20130130170750.GA5217@gmail.com>
Message-ID: <CACRpkdZ_4kaEFHmLvgfrsimg7YSY2gnfsQMVfzcYniVT-oR+jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 6:07 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The preference is to use '-' instead of '_' in compatible strings.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

This does not apply to pinctrl devel. (Same as linux-next)

This is because the two hunks, as compared to the last patch,
were already in-tree, they were changed as part of patch:

commit e32af889458837d11a1ec5ec98934a1e711b049d
Author: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
Date:   Mon Dec 17 15:53:24 2012 +0100

    pinctrl/nomadik: add device tree support

    This implements pin multiplexing and pin configuration for
    the Nomadik pin controller using the device tree.

    Signed-off-by: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
    Reviewed-by: Stephen Warren <swarren@nvidia.com>
    Reviewed-by: Philippe Langlais <philippe.langlais@stericsson.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Since I don't dare to squash this oneliner into that patch
for fear of Lee's rage, I leave the old patch as it is.

Yours,
Linus Walleij
