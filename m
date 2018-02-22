From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 14:59:44 +0100
Subject: [PATCH] watchdog: coh901327: make license text and module licence
 match
In-Reply-To: <20180210092702.4393-1-marcus.folkesson@gmail.com>
References: <20180210092702.4393-1-marcus.folkesson@gmail.com>
Message-ID: <CACRpkdaGeqCOhSwzNZh4AObEB16SHgY+X9eB8G4chSdytbVv_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 10:27 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:

> Licence text is specifying "GPLv2" but the MODULE_LICENSE is set to "GPLv2
> or later".
>
> See include/linux/module.h:
> "GPL"                           [GNU Public License v2 or later]
> "GPL v2"                        [GNU Public License v2]
>
> When on it, add SPDX identifier tag.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
