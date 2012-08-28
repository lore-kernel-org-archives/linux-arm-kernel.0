From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 14:10:08 -0400
Subject: [PATCH] ARM: Kirkwood: Iomega ix2-200 DT support
In-Reply-To: <2b8d12ce68911cc12c96dcdd60c3345b72d25780.1345472556.git.alanbutty12@gmail.com>
References: <cover.1345472556.git.alanbutty12@gmail.com>
 <2b8d12ce68911cc12c96dcdd60c3345b72d25780.1345472556.git.alanbutty12@gmail.com>
Message-ID: <20120828181008.GG19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 03:29:07PM +0100, Alan M Butler wrote:
> Patch version 5.
> Add support for the Iomega ix2-200.
> Led's and buttons working as of kernel 3.6-rc2
> 
> the 3 lines in the network interface do seem to be required as
> removing either causes the network card to not be able to reach
> the network (at least on my device).
> 
> Product page:
> http://go.iomega.com/en/products/network-storage-desktop/storcenter-network-storage-solution/network-hard-drive-ix2-200-cloud/?partner=4735#tech_specsItem_tab
> 
> Signed-off-by: Alan M Butler <alanbutty12@gmail.com>

Alan,

Great work!

Applied to:

git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7-v2

I'll wait for the mv_sata fix and the gpio-keys fix before I send a pull
request to the arm-soc maintainers.

thx,

Jason.
