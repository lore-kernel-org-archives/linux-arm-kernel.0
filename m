From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 27 Apr 2016 11:29:09 -0400
Subject: [PATCH v2 2/7] ARM: dts: lpc32xx: ea3250: add NAND partitions
 device node
In-Reply-To: <1461705034-355-3-git-send-email-vz@mleia.com>
References: <1461705034-355-1-git-send-email-vz@mleia.com>
 <1461705034-355-3-git-send-email-vz@mleia.com>
Message-ID: <1461770949.31696.0.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-04-27 at 00:10 +0300, Vladimir Zapolskiy wrote:
> To declare MTD OF partitions NAND controller device node should have
> a special 'partitions' subnode, the change removes a debug message
> from mtd/ofpart on boot:
> 
>   nxp_lpc3220_slc: 'partitions' subnode not found on /ahb/flash at 20020000.
>   Trying to parse direct subnodes as partitions.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> * on conversion added missing 'compatible = "fixed-partitions";',
>   thanks to Sylvain for finding
> 
>  arch/arm/boot/dts/ea3250.dts | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
