From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Aug 2018 23:31:01 +0800
Subject: [PATCH v3 1/2] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
In-Reply-To: <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
Message-ID: <20180821153059.GD32159@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 07:14:19PM +0300, Leonard Crestez wrote:
> This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
> 
> That commit followed the reference manual but unfortunately the imx7d
> manual is incorrect.
> 
> Tested with ath9k pcie card and confirmed internally.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
