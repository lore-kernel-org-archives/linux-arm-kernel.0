From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jun 2013 10:56:42 +0200
Subject: [PATCH v2 0/8] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130618105642.77c4f50d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On Thu,  6 Jun 2013 18:41:20 +0200, Thomas Petazzoni wrote:

> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.
> 
> This version 2 follows the RFC version sent on March, 26th 2013. This
> is based on work done by Lior Amsalem <alior@marvell.com>.
> 
> The patches do the following:
> 
>  * Patch 1 comes from Thierry Redding, and adds a minimal msi_chip
>    infrastructure.
> 
>    This needs to be reviewed/acked by Bjorn Helgaas.
> 
>  * Patch 2 extends the msi_chip infrastructure with a small registry,
>    so that one driver can register an msi_chip, and another driver can
>    find the msi_chip associated to a particular Device Tree node.
> 
>    This needs to be reviewed/acked by Bjorn Helgaas.

Could you have a look at those two patches and let me know what you
think?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
