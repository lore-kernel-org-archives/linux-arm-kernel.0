From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 08:57:49 -0800
Subject: [GIT PULL] Renesas pinmux for v3.9
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130129165749.GB16188@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 11:23:36AM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following pinmux enhancements for 3.9.
> 
> As discussed previously this series includes changes for shmobile (ARM
> based SoC), the SH architecture and pinmux.  It has been agreed by the
> maintainers, Paul Mundt, Linus Walleij and myself in conjunction with the
> patch-series author Laurent Pinchart and arm-soc co-maintainer Olof
> Johansson to take this seies through my renesas tree and thus the arm-soc
> tree as a single branch to avoid a complex set of branch dependencies.
> 
> These changes have been sitting in next for several weeks now.
> 
> I expect there to be a follow-up series of similar complexity
> in the 3.10 time-frame. A focus of that series being to add DT bindings.
> 
> ----------------------------------------------------------------
> The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:
> 
>   Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git pfc

This will go in through a next/sh-pinmux branch on its own given the
size of the branch.  It's been pulled and merged in with for-next.

Thanks!


-Olof
