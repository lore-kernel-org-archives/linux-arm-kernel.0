From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Jul 2018 10:19:41 -0700
Subject: [GIT PULL] SoCFPGA updates for v4.19, part1
In-Reply-To: <1530540338-27657-1-git-send-email-dinguyen@kernel.org>
References: <1530540338-27657-1-git-send-email-dinguyen@kernel.org>
Message-ID: <CAOesGMiQqE8SssVt_KW7epbz=Sn-GPB4R=EN7tA3KG4as9QdYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 7:05 AM, Dinh Nguyen <dinguyen@kernel.org> wrote:
> Hi Arnd, Kevin, and Olof:
>
> Please pull in these SoCFPGA updates for v4.19. The reason it's based on
> v4.18-rc3 is that there are some dependencies on fixes that went into
> v4.18-rc2.

That's fine, I'm basing all next/* branches on -rc3 since it's where
the defconfig renormalization went in, and it's easiest to avoid
conflicts that way.

> The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:
>
>   Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.19_part1
>
> for you to fetch changes up to 70455ac7ffb6b707af1e56e1993af82906fddaae:
>
>   arm64: dts: stratix10: Add SPI node clocks for Stratix10 (2018-07-02 08:44:15 -0500)

Merged into next/dt. Thanks!


-Olof
