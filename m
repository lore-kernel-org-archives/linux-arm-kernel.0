From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Mar 2014 13:01:16 -0700
Subject: [GIT PULL 1/2] ARM: Keystone DTS updates for 3.15
In-Reply-To: <1394005703-6624-1-git-send-email-santosh.shilimkar@ti.com>
References: <1394005703-6624-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140311200116.GD31877@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 03:48:22PM +0800, Santosh Shilimkar wrote:
> Hi Arm-soc folks,
> 
> Please pull below keystone DTS updates for 3.15. It merges cleanly with
> arm-soc 'for-next' and 'next/dt' heads.
> 
> Please note that you get a trivial merge conflict while merging to the
> latest Linus tip, because of bug fix commit 565bbdcd3b{ARM: keystone:
> dts: fix clkvcp3 control register address} which got merged post
> 3.14-rc5. If it needs to be avoided then I need to rebase the PULL
> request on top of 3.14-rc6 when it gets tagged. Do let me know if
> thats needed.
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts
> 
> for you to fetch changes up to 82c04f71ecacf225cdd0ea96ec91f28ca9db70a1:
> 
>   ARM: dts: keystone: add AEMIF/NAND device entry (2014-02-28 21:05:24 -0500)

Merged. See comments on the per-board table in keystone.c, but that can be
rolled back and changed on top of this.


-Olof
