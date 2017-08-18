From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 11:59:08 +0200
Subject: [GIT PULL] i.MX fixes for 4.13, round 3
In-Reply-To: <20170818015546.GJ7608@dragon>
References: <20170818015546.GJ7608@dragon>
Message-ID: <CAK8P3a2ERuzsFNw=AfJ9bHqoMHcee1oS93A-8nFP5=Jad9xkOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 3:55 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 8317562097acec4c9e9750eb91115687931bca35:
>
>   ARM: dts: i.MX25: add ranges to tscadc (2017-08-05 13:22:32 +0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.13-3
>
> for you to fetch changes up to c40bc54fdf2d52a80f66b365f1eac9d43b32e107:
>
>   ARM: dts: imx6qdl-nitrogen6_som2: fix PCIe reset (2017-08-18 09:40:40 +0800)
>
> ----------------------------------------------------------------
> i.MX fixes for 4.13, round 3:
>  - Fix PCIe reset GPIO of imx6qdl-nitrogen6_som2 board, which was
>    a bad copy from nitrogen6_max device tree.

Pulled into fixes, thanks!

       Arnd
