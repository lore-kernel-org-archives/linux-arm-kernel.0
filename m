From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:27:05 -0800
Subject: [GIT PULL] Xilinx Zynq DT changes for v4.5
In-Reply-To: <566EB323.2070309@xilinx.com>
References: <566EB323.2070309@xilinx.com>
Message-ID: <20151222192705.GS30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 01:16:35PM +0100, Michal Simek wrote:
> Hi,
> 
> please pull these changes to your tree.
> 
> Thanks,
> Michal
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.5

Applied, thanks.

> 
> for you to fetch changes up to 400b6a0cbef55d1ae32808eaa1ef1c28820bf6ac:
> 
>   ARM: dt: zynq: Add labels to cpu nodes to allow overriding OPPs.
> (2015-12-14 09:48:39 +0100)
> 
> ----------------------------------------------------------------
> arm: Xilinx Zynq dt patches for v4.5
> 
> - Various small DT changes, GPIO, slcr, cpu label
> 
> ----------------------------------------------------------------
> Masahiro Yamada (1):
>       ARM: dts: zynq: describe SLCR as simple-mfd rather than simple-bus
> 
> Moritz Fischer (1):
>       ARM: dt: zynq: Add labels to cpu nodes to allow overriding OPPs.

Nit: Please use/fix up consistent prefixes when you apply patches.


-Olof
