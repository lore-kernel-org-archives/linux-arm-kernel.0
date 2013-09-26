From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Sep 2013 12:39:35 +0200
Subject: [GIT PULL] ux500 device tree changes for v3.13 take 1
In-Reply-To: <CAOesGMhd-m+idtf7Tc9A64Yr_HJSsyK5XhCknsXQxJSaKQddBw@mail.gmail.com>
References: <CACRpkdZ1Jb+LmMxR-jJX2rZ+dPEWjGG-+VBJVUH8o-TaN_hOVA@mail.gmail.com>
 <CAOesGMhd-m+idtf7Tc9A64Yr_HJSsyK5XhCknsXQxJSaKQddBw@mail.gmail.com>
Message-ID: <CACRpkdbUL-GVDCi8CLnF1h4WTTOP_1Fa=8o1HNFiRaBn15wk4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 6:53 AM, Olof Johansson <olof@lixom.net> wrote:

> There seems to be a set of duplicated commits in this branch, the
> AUXDATA removal (which for some unknown reason was split up into 8
> patches instead of done in only one) was committed on two branches,
> for example. One branch contained commits by you, the other by Lee.

Yeah what a mess. I have created a clean, rebased branch
and signed-off every individual commit.

> Also, should I drop the i2c patch from fixes, since it's included
> here? If it's been broken for that long I'm guessing it's not urgent
> to get fixed in 3.12? I also noticed that you forgot to sign off when
> you applied it.

OK drop it off fixes, let's say v3.12 is recommended to use
with ATAG, v3.13 is recommended to use with DT.

> Oh, and there's a mix of you and Lee as the committer on the main
> branch too, maybe because you merged a fast-forward branch from him
> that didn't get documented in the merge history because of that? It's
> good to document those by using --no-ff, but not a huge deal -- just
> something to think about in the future.

Hm I've made a clean branch which should be me as committer
on everything, you'll have a pull request on that shortly.

Yours,
Linus Walleij
