From: olof@lixom.net (Olof Johansson)
Date: Sun, 15 Apr 2012 11:19:06 -0700
Subject: [GIT PULL] i.MX board feature patches
In-Reply-To: <20120411083342.GM3852@pengutronix.de>
References: <20120411083342.GM3852@pengutronix.de>
Message-ID: <CAOesGMhakTpuXWnHUnJqiEbzPBeXE1digiyJ+LeoPbjhyFAoLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 11, 2012 at 1:33 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Arnd, Olof,
>
> Please pull the following board feature patches for i.MX
>
> Thanks
> ?Sascha
>
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
>
> ?Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
>
> are available in the git repository at:
>
> ?git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-features-board-20120411
>
> for you to fetch changes up to e7259f7ca3a0c7a269fecb61156224ddd3edb92c:
>
> ?Visstrim_M10: Add board version detection. (2012-04-11 10:16:03 +0200)
>
> ----------------------------------------------------------------
> misc i.MX board specific features
>
> ----------------------------------------------------------------
> Alex Gershgorin (1):
> ? ? ?ARM: regulator: i.MX35-PDK Add regulator support
>
> Javier Martin (1):
> ? ? ?Visstrim_M10: Add board version detection.


Just because I've already have given you the "please keep this in mind
in the future" comments before, I'm going to ask you to respin this
branch and fix the patch subjects on the two above patches. The first
should probably be "ARM: imx: Add regulator support for i.MX35-PDK" or
so, and the second one needs "ARM: imx:" prefix.

Branch otherwise looks reasonable, so respin with that fixed and we'll
pull it in.


-Olof
