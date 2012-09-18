From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Tue, 18 Sep 2012 07:35:43 +0000
Subject: [PATCH v3 4/4] ARM: dts: AM33XX: Add lis331dlh device tree data
 to am335x-evm
In-Reply-To: <20120917153559.e07ca263.akpm@linux-foundation.org>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
 <1347866602-2088-5-git-send-email-anilkumar@ti.com>
 <20120917153559.e07ca263.akpm@linux-foundation.org>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA32D69@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Sep 18, 2012 at 04:05:59, Andrew Morton wrote:
> On Mon, 17 Sep 2012 12:53:22 +0530
> AnilKumar Ch <anilkumar@ti.com> wrote:
> 
> > Add lis331dlh device tree data to am335x-evm.dts. In AM335x EVM
> > lis331dlh accelerometer is connected to I2C2 bus. So this patch
> > change the status of I2C2 node to "okay" to use I2C2 bus. Also
> > added all the required platform data to am335x-evm.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
> 
> Your arch/arm/boot/dts/am335x-evm.dts differs significantly from the
> one in linux-next (it should not do so), so I didn't do anything with
> this patch.
> 

Thanks for pushing remaining patches.

ACK from the reviewers(Arnd) will help to include in linux-omap branch.

Thanks
AnilKumar
