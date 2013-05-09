From: dianders@chromium.org (Doug Anderson)
Date: Thu, 9 May 2013 15:07:25 -0700
Subject: [PATCH] ARM: exynos: defconfig update
In-Reply-To: <1368133099-16997-1-git-send-email-olof@lixom.net>
References: <1368133099-16997-1-git-send-email-olof@lixom.net>
Message-ID: <CAD=FV=VMCLk0h0XxJv1Q3EkpottVkpwKEa87McmmipdJA7TN+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Thu, May 9, 2013 at 1:58 PM, Olof Johansson <olof@lixom.net> wrote:
> +CONFIG_ZBOOT_ROM_TEXT=0x0
> +CONFIG_ZBOOT_ROM_BSS=0x0

Probably these aren't needed, but don't hurt since the default is 0.
This seems to pop up a lot since there are lots of legacy configs that
have 0x0 here.

Either with or without that fixup, this looks reasonable to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
