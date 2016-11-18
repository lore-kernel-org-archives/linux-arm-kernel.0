From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 09:59:13 -0800
Subject: [GIT PULL 1/5] i.MX non-critical fixes for 4.10
In-Reply-To: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
References: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20161118175913.GD8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 05:00:27PM +0800, Shawn Guo wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fix-nc-4.10
> 
> for you to fetch changes up to 72649a46067903d00f46e2ebef6543768224f1a0:
> 
>   ARM: dts: imx6q-cm-fx6: fix fec pinctrl (2016-11-14 15:31:01 +0800)
> 
> ----------------------------------------------------------------
> i.MX non-critical fixes for 4.10:
>  - A series from Vladimir to fix broken i.MX31 DT clock initialization.
>    As i.MX31 DT support is still not quite complete, the changes are
>    tested on qemu kzm target and mx31lite board with simple written DTS
>    files.
>  - A fix for CompuLab's sbc-fx6 baseboard to remove wrong fec pinctrl
>    setting.
>  - A DTS correction for i.MX6QP to reflect the change that the gate of
>    LDB clock has been moved before the divider.
>  - An imx7d-pinfunc fix for UART pinmux defines

Merged, thanks.


-Olof
