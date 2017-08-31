From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 15:24:37 +0200
Subject: [v2] ARM: multi_v7_defconfig: make eSDHC driver built-in
In-Reply-To: <20170825031919.22492-1-yangbo.lu@nxp.com>
References: <20170825031919.22492-1-yangbo.lu@nxp.com>
Message-ID: <CACRpkdZx7xZF1-r1_qMHkeV5AecCfpEoJ=JfMEA7+xcW=kUogw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 5:19 AM, Yangbo Lu <yangbo.lu@nxp.com> wrote:

> Sometimes root file system is deployed on SD card. It's
> proper to build eSDHC driver into kernel.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
>         - Added more reviewers (by get_maintainer.pl).

Makes sense.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Send the patch directly to the SoC maintainers arm at kernel.org
and ask them to apply it directly.

Yours,
Linus Walleij
