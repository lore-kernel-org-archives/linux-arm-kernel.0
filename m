From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 10:53:44 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v4.3
In-Reply-To: <55BB31E8.7040806@monstr.eu>
References: <55BB31E8.7040806@monstr.eu>
Message-ID: <20150805085344.GH6390@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 31, 2015 at 10:29:28AM +0200, Michal Simek wrote:
> Hi,
> 
> please pull these SoC changes to your tree.
> 
> Thanks,
> Michal
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.3
> 
> for you to fetch changes up to e4a9288942392965bd5cfad93d9996b83c0dc4a6:
> 
>   ARM: zynq: reserve space for jump target in secondary trampoline
> (2015-07-31 10:24:41 +0200)

Merged, however:

> Arun Chandran (1):
>       ARM: zynq: Fix earlyprintk in big endian mode
> 
> Masahiro Yamada (1):
>       clk: zynq: remove redundant $(CONFIG_ARCH_ZYNQ) in Makefile

This should have gone through the clk tree. Seems small and simple enough that
I'll take it, but please send patches through appropriate maintainers.

(Adding Mike and Stephen on cc so they know about it).


-Olof
