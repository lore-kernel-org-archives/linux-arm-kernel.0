From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jan 2012 23:49:40 -0800
Subject: [GIT PULL] ux500 fixes for v3.3
In-Reply-To: <1327509408-3234-1-git-send-email-linus.walleij@linaro.org>
References: <1327509408-3234-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAOesGMhoNGkFxrPH7OuyHzpcg9Z8FTaGcYJ+4XLPGOfe7WpYiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 25, 2012 at 8:36 AM, Linus Walleij <linus@df.lth.se> wrote:
> Hi Arnd, Olof,
>
> These are some fixes for ux500 that would be nice to have
> for the 3.3-rc:s through ARM SoC.
>
> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
>
> ?Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
>
> are available in the git repository at:
> ?git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git fixes-for-arm-soc
>
> Philippe Langlais (2):
> ? ? ?mach-ux500: musb: now musb is always in OTG mode
> ? ? ?mach-ux500: no MMC_CAP_SD_HIGHSPEED on Snowball
>
> Srinidhi KASAGAR (1):
> ? ? ?mach-ux500: enable ARM errata 764369
>
> srinidhi kasagar (1):
> ? ? ?mach-ux500: do not override outer.inv_all


Thanks, pulled.

BTW, in the future please migrate to using the common prefix format instead:

ARM: ux500: <...>


-Olof
