From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 16:56:01 +0200
Subject: [PATCH 2/3] kbuild: remove unnecessary variable initializaions
In-Reply-To: <1410258381-7088-3-git-send-email-yamada.m@jp.panasonic.com>
References: <1410258381-7088-1-git-send-email-yamada.m@jp.panasonic.com>
 <1410258381-7088-3-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <CACRpkdZxLrdvPPwrXgTn_oVntxz_f+GCdsdSbDZ0R0Mre6F_Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 12:26 PM, Masahiro Yamada
<yamada.m@jp.panasonic.com> wrote:

> Clearing obj-y, obj-m, obj-n, obj- in each Makefile is
> a useless habit.
>
> They are non-exported variables; therefore they are always empty
> whenever descending into each subdirectory.
> (Moreorver, obj-y and obj-m are also set to empty at the beginning
> of scripts/Makefile.build)
>
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
