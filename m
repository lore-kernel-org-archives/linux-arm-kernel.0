From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 11:40:30 +0800
Subject: [PATCH 1/3] ARM: dts: imx6sx: Fix the PCI representation
In-Reply-To: <1511304601-1149-3-git-send-email-festevam@gmail.com>
References: <1511304601-1149-1-git-send-email-festevam@gmail.com>
 <1511304601-1149-3-git-send-email-festevam@gmail.com>
Message-ID: <20171129034029.GE9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 08:50:01PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Currently the imx pci driver fails to probe on i.MX6SX.
> 
> Fix the PCI representation so that the driver can be probed and
> PCI devices can be detected.
> 
> Tested on a im6sx-sdb board:
> 
> # lspci 
> 00:00.0 Class 0604: 16c3:abcd
> 01:00.0 Class 0280: 8086:08b1
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
