From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Oct 2015 16:33:40 +0800
Subject: [PATCH v13 1/2] ARM: dts: vf610twr: add NAND flash controller
 peripherial
In-Reply-To: <1444262316-30588-1-git-send-email-stefan@agner.ch>
References: <1444262316-30588-1-git-send-email-stefan@agner.ch>
Message-ID: <20151008083340.GA22946@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 04:58:35PM -0700, Stefan Agner wrote:
> This adds the NAND flash controller (NFC) peripherial. The driver
> supports the SLC NAND chips found on Freescale's Vybrid Tower System
> Module. The Micron NAND chip on the module needs 4-bit ECC per 512
> byte page. Use 24-bit ECC per 2k page, which is supported by the
> driver.
> 
> Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both, thanks.

Stefan,

In the future, please use my new email address which has been updated to
MAINTAINERS for a couple of release cycles.

Shawn
