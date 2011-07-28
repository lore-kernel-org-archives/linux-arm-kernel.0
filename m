From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Jul 2011 15:51:20 +0300
Subject: [PATCH 2/3] arch: arm: mach-cns3xxx: Add gpiolib support
In-Reply-To: <1311873401-26075-1-git-send-email-tommy.lin.1101@gmail.com>
References: <1311873401-26075-1-git-send-email-tommy.lin.1101@gmail.com>
Message-ID: <20110728125119.GD9069@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 29, 2011 at 01:16:41AM +0800, Tommy Lin wrote:
>  arch/arm/mach-cns3xxx/gpio.c                 |  692 ++++++++++++++++++++++++++

why is this driver under arch/arm/mach-cns3xxx instead of drivers/gpio ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110728/687ad035/attachment.sig>
