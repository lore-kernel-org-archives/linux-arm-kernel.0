From: daniel.price@gmail.com (Daniel Price)
Date: Tue, 6 Aug 2013 11:22:01 -0700
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130806182201.GB2123@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 03:25:03PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.

Thomas,

I tested this set of patches on a custom Marvell Armada XP 78260 based
board.  It was connected to another system over PCIe, through a
non-transparent bridge; MSI support was required.  We also tested a
similar configuration using the Armada XP GP platform.  The patch seems
to work for us.  Many thanks!

Tested-by: Daniel Price <daniel.price@gmail.com>

	-dp

--
Daniel Price; daniel.price at gmail.com; Twitter: @danielbprice
