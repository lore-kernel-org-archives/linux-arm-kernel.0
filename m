From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jul 2015 11:18:49 +0200
Subject: [GIT PULL] SoCFPGA fixes for v4.2-rc1
In-Reply-To: <1436543297-3254-1-git-send-email-dinh.linux@gmail.com>
References: <1436543297-3254-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <20150714091849.GC20686@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 10:48:17AM -0500, dinh.linux at gmail.com wrote:
> Hi Arnd, Kevin, Olof:
> 
> Please pull in these fixes for v4.2-rc1.
> 
> Thanks,
> 
> Dinh
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_fixes_for_v4.2-rc1
> 
> for you to fetch changes up to 93abc72bc7901cfc61a2871da7a565c9fdb26108:
> 
>   ARM: socfpga: dts: Fix entries order (2015-07-07 08:58:02 -0500)

Merged. However, a reordering of a DTS file isn't really a fix, in the
future please queue up for next release instead (unless the order is
somehow causing a problem that needs to be addressed).


-Olof
