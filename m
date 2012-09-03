From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 13:25:03 +0200
Subject: [PATCH 3/3] pinctrl: sirf: add DT-binding pinmux mapping support
In-Reply-To: <1345690074-31327-4-git-send-email-Barry.Song@csr.com>
References: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
 <1345690074-31327-4-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdY1o1i4TjPHKu-LMKwM2b7Hr9fJ5PZZqY0crirjYi57HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 4:47 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> This makes us possible to define pinmux mapping in board-specific DTS.
> prima2.dtsi provides all possible (groups,functions) configuration, and
> device in .dts select configurations from dtsi files.
>
> Signed-off-by: Barry Song <Barry.Song@csr.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

(Again, assume that you take this through ARM SoC.)

Yours,
Linus Walleij
