From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 06:32:08 -0700
Subject: [GIT PULL] arm64: dts: TI AM65x changes for 4.20
In-Reply-To: <404ebcc1-7e8c-c505-a6ac-10a94f6bd608@ti.com>
References: <404ebcc1-7e8c-c505-a6ac-10a94f6bd608@ti.com>
Message-ID: <20180923133208.zwuxw5jpjq24afm3@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 09:54:08PM +0300, Tero Kristo wrote:
> Hi ARM-SoC team,
> 
> Here are the TI AM65x DTS changes towards 4.20 merge window. Applied on top
> of 4.19-rc2 basically just because of some testing considerations, please
> let me know if that is not fine.

No worries - next/dt is already on -rc2 in this case. If in doubt, see what our
for-next has as a base at the time. In general rc1-3 are fair game. Beyond
that, it's on a case by case basis and ask if you're uncertain.

> 
> The following changes since commit 57361846b52bc686112da6ca5368d11210796804:
> 
>   Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux
> tags/am654-for-v4.20
> 
> for you to fetch changes up to 42e54f6467ecc25f464d74c0fcea0c9fab1c2e3b:
> 
>   arm64: dts: ti: k3-am6: Add Device Management Security Controller support
> (2018-09-18 18:25:06 +0300)
> 
> ----------------------------------------------------------------
> TI AM654 support for v4.20 merge window.
> 
> This branch adds changes for the Texas Instruments AM654 SoC. Included
> changes are:
> - Add uart nodes
> - Change address cells and size-cells of interconnect tfrom 1 to 2
> - Add secure proxy instance for main domain
> - Add DMSC support

Merged, thanks!


-Olof
