From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 18:13:21 +0200
Subject: [GIT PULL] i.MX device tree updates for 4.17, round 2
In-Reply-To: <20180316022854.GR26859@dragon>
References: <20180316022854.GR26859@dragon>
Message-ID: <CAK8P3a0xYUnNWqCg7jbDzvhyLnx1XMBxgiCSPNw1AE7QDy_pBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 3:28 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit f4be9b77fac3d8141add1d84e75199f0e0ddd5a3:
>
>   ARM: dts: i.MX25: define SSI FIFO depth (2018-03-12 15:23:36 +0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.17-2
>
> for you to fetch changes up to 326e7ba992cbe17c12d4235f65d72c6e222a73a1:
>
>   ARM: dts: imx6ul-isiot: Pass the required '#sound-dai-cells' (2018-03-16 09:13:38 +0800)
>
> ----------------------------------------------------------------
> i.MX device tree updates for 4.17, round 2:
>  - Add missing property '#sound-dai-cells' for sgtl5000 codec node
>    in imx6ul-isiot board to fix warning seen with DTC 1.4.6.
>  - Use stdout-path instead of linux,stdout-path to fix DTC warning
>    reported by DTC 1.4.6.

I found this one after resynching my email, pulled into next/dt now.

      Arnd
