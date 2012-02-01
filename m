From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2012 21:11:55 +0100
Subject: [PATCH 3/4] ARM: tegra: Switch to new pinctrl driver
In-Reply-To: <20120201082011.GK7399@quad.lixom.net>
References: <1327083746-31430-1-git-send-email-swarren@nvidia.com>
 <1327083746-31430-3-git-send-email-swarren@nvidia.com>
 <CACRpkdZ_hBviswq7pXoLozC8gjzvowCBrj9yjw1xJT79b5rtwQ@mail.gmail.com>
 <20120201082011.GK7399@quad.lixom.net>
Message-ID: <CACRpkdZ76PamNGOuhuqNvMx9k6hRR2MD2L7sJnv7nU_A45Yypg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2012 at 9:20 AM, Olof Johansson <olof@lixom.net> wrote:

> This series is:
> Acked-by: Olof Johansson <olof@lixom.net>

OK that's great!

> can you land this series in a stable branch in
> your tree that you promise not to rebase between now and upstream
> submission?

I thinkso, I rebased to some fixes from -rc2 today but no need to
do that again, there is one bug fix which may end up in both
mainline and my tree but whatever, git will cope.

However I am waiting for Stephen to do some fixes and arrive
at a final version first.

Linus Walleij
