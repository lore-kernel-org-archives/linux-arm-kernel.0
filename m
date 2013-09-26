From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Sep 2013 21:22:54 -0700
Subject: [GIT PULL] Nomadik AUXDATA removal
In-Reply-To: <CACRpkdYOLW8ZurGmQdPZY+Ysh_TkLwj4xrc758C6ojVtMnkMRg@mail.gmail.com>
References: <CACRpkdYOLW8ZurGmQdPZY+Ysh_TkLwj4xrc758C6ojVtMnkMRg@mail.gmail.com>
Message-ID: <CAOesGMgX_dayXMx=FmBEi7ZQ=9JigS-VGxYwitVnS1h0VbMLCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 12:39 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> Hi ARM SoC folks,
>
> these three patches tear out the remaining AUXDATA in the
> Nomadik platform and replace it with device tree.
>
> Corresponding driver changes are coming from respective
> subsystem tree and there are no build dependencies.
>
> Please pull it in on some suitable branch in the ARM SoC
> tree.
>
> Yours,
> Linus Walleij
>
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/for-arm-soc
>
> for you to fetch changes up to 2c5a7424dae5e34b977716f9f0ab8a99d00cc7bc:
>
>   ARM: nomadik: delete FSMC platform data (2013-09-24 21:25:19 +0200)

Pulled, thanks!


-Olof
