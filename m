From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 23 Mar 2012 16:05:47 +0530
Subject: [RFC][PATCH 0/5] Convert GPMC to driver
In-Reply-To: <1332484567-21710-1-git-send-email-afzal@ti.com>
References: <1332484567-21710-1-git-send-email-afzal@ti.com>
Message-ID: <CAMQu2gzSk26kWgB4+xjB007_zogxQkR9c0po42n56wYYySz65w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 12:06 PM, Afzal Mohammed <afzal@ti.com> wrote:
> Hi,
>
> Convert GPCM code to be a driver. Existing GPMC
> NAND platform handling has been modified to work
> with the new GPMC driver (patches 2 & 3). Patch 5
> is to test the driver in OMAP3EVM.
>
> Once all the users has been converted to use this
> driver, would be converted to MFD type.
>
Much needed series. Thanks Afzal for doing it.

> TODO:
> 1. Let OMAP NAND driver deal with GPMC NAND block
> 2. Remove struct gpmc * stored as static
> 3. Convert all peripherals to use GPMC driver
> 4. Devise method to handle OneNAND cleanly
> 5. Handle acquiring CS# cases
> 6. Convert to MFD driver
>


> Afzal Mohammed (5):
> ?ARM: OMAP2+: gpmc: driver conversion
> ?ARM: OMAP2+: nand: create platform data structure
> ?ARM: OMAP2+: gpmc-nand: populate gpmc configs
> ?mtd: nand: omap2: obtain memory from resource
> ?OMAP3EVM: Test gpmc-nand
>
Will have a look at your series next week.

Regards
Santosh
