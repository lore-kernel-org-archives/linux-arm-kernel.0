From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 23:26:20 -0700
Subject: [GIT PULL 5/5] ARM: mvebu: clock SoC reorg for v3.11
In-Reply-To: <20130528203021.GK31290@titan.lakedaemon.net>
References: <20130528202140.GG31290@titan.lakedaemon.net>
 <20130528202433.GH31290@titan.lakedaemon.net>
 <20130528203021.GK31290@titan.lakedaemon.net>
Message-ID: <20130601062620.GS5189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 04:30:21PM -0400, Jason Cooper wrote:
> 
> The following changes since commit 3d9939c92efdd4ced672b94994959ca71b141cb8:
> 
>   pci: mvebu: fix return value check in mvebu_pcie_probe() (2013-05-27 15:51:56 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/seb_clk-3.11
> 
> for you to fetch changes up to 279f759aac0990402407d97b21475677f499f4ac:
> 
>   clk: mvebu: desintegrate obsolete file (2013-05-28 15:18:37 +0000)

Pulled in as mvebu/clk-cleanup.


> mvebu clock restructuring for v3.11
> 
>  - clk: mvebu
>     - reorganize by SoC to remove built up #ifdefs
>     - add clk flags per clock gate
> 
> Note: this branch only depends on mvebu/pcie in order to prevent managing a
> tricky modify/remove file merge conflict.  By rebasing on mvebu/pcie, we are
> able to build the resolution into the patch series.  The change is small, and
> has been tested by the respective authors.

BTW, it would have been fine to expose this as well, especially if
you'd let us know up front and pushed a proposed solution that we could
compare with.


-Olof
