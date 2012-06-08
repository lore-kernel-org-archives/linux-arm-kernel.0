From: olof@lixom.net (Olof Johansson)
Date: Fri, 8 Jun 2012 01:23:19 -0700
Subject: [GIT PULL] i.MX fixes
In-Reply-To: <20120607200451.GQ30400@pengutronix.de>
References: <20120607200451.GQ30400@pengutronix.de>
Message-ID: <CAOesGMhh68fWWpMfqBg2gyzWOo8x+_rbQkc-hzP-PRcu8jZA3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 1:04 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Olof, Arnd,
>
> Please pull the following i.MX fixes for -rc.
>
> Sascha
>
> The following changes since commit 76e10d158efb6d4516018846f60c2ab5501900bc:
>
> ?Linux 3.4 (2012-05-20 15:29:13 -0700)
>
> are available in the git repository at:
>
> ?git://git.pengutronix.de/git/imx/linux-2.6.git imx/fixes

Pulled, thanks. In the future, for fixes you can aggregate them in one
branch -- we normally just care about topics for merge window staging.

Also, have you noticed that imx_v4_v5_defconfig has a build failure in
mx2_camera.c?

drivers/media/video/mx2_camera.c: In function 'mx2_camera_set_bus_param':
drivers/media/video/mx2_camera.c:1032:42: error: 'pixfmt' undeclared
(first use in this function)
drivers/media/video/mx2_camera.c:1032:42: note: each undeclared
identifier is reported only once for each function it appears in


-Olof
