From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 11:56:45 +0200
Subject: [PATCH v2 0/4] ARM: dts: at91: Migrate to the new EBI/NAND
 bindings
In-Reply-To: <1496136054-12390-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1496136054-12390-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170531095645.7jwews2fbofhntjk@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/2017 at 11:20:50 +0200, Boris Brezillon wrote:
> Hello,
> 
> This is the last step of the EBI/NAND bindings rework started here [1].
> 
> The first patch is adding missing nfc-io bindings doc to atmel-nand.txt
> and can be applied independently.
> 
> Patches 2 and 3 are migrating all at91/sama5 SoCs (except the
> at91rm9200) to the new EBI/NAND representation introduced in 4.12.
> 
> The last patch is showing how one can add a non-NAND device under the
> EBI bus.
> 
> Regards,
> 
> Boris
> 
> [1]http://lkml.iu.edu/hypermail/linux/kernel/1703.2/00124.html
> 
> Changes since v1:
> - Cc board maintainers
> - merge patches 3 and 4 into a single patch doing all board
>   modifications
> 
> Boris Brezillon (4):
>   dt-bindings: mtd: atmel-nand: Document the nfc-io bindings
>   ARM: dts: at91: Declare EBI/NAND controllers
>   ARM: dts: at91: Switch to the new NAND bindings
>   ARM: dts: at91: Add the NOR flash available on sama5d3 dev kits
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
