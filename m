From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 Apr 2013 09:25:45 -0700
Subject: [GIT PULL 4/4] ARM: imx: device tree changes for 3.10
In-Reply-To: <1365520775-28478-4-git-send-email-shawn.guo@linaro.org>
References: <1365520775-28478-1-git-send-email-shawn.guo@linaro.org>
 <1365520775-28478-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130418162545.GA7083@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 09, 2013 at 11:19:35PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> It's based on imx-cleanup-3.10 and Stephen Warren's "[GIT PULL] dt:
> run C pre-processor on *.dts, create some standard headers" to resolve
> dependency and conflicts.
> 

That's not adequate description of a dependency. We need to know what git
branch, not what patch posting, this is based on. And we need to make sure that
said git branch will never be rebased on the way up to Linus. That's
a three-way handshake between you, us and the maintainer with that dependency
in his tree.

> The following changes since commit 8b9ad9f67d094efd2c2765d82cc1866bee9052c2:
> 
>   Merge remote-tracking branch 'swarren/for-3.10/dtc-cpp-chroot-std-headers' into imx/dt (2013-04-09 22:52:42 +0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.10
> 

Pulled, after finding Rob Herring's tree and finding him on irc to make sure he
doesn't rebase that branch.


-Olof
