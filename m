From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:50:41 -0800
Subject: [GIT PULL 5/5] omap defconfig changes for v4.10
In-Reply-To: <582b7c9d.473f630a.d4410.a225SMTPIN_ADDED_BROKEN@mx.google.com>
References: <pull-1479236877-351747>
 <582b7c9d.473f630a.d4410.a225SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20161119005041.GH15902@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 01:22:23PM -0800, Tony Lindgren wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/defconfig-signed
> 
> for you to fetch changes up to 9c106e4efab2ec96daebb7bdd0bb61602fd52e7a:
> 
>   ARM: omap2plus_defconfig: Run make savedefconfig to save some space (2016-11-15 11:01:24 -0800)
> 
> ----------------------------------------------------------------
> Defconfig changes for omaps for v4.10 merge window:
> 
> - Enable tsc2004 touchscreen as a loadable module
> 
> - Enable REGULATOR_GPIO, dra71-evm needs this for MMC voltage
> 
> - Enable LP873x PMICs for dra71x-evm
> 
> - Run make savedefconfig to save some space and make it
>   easier to generate minimal patches against it

Merged, thanks.


-Olof
