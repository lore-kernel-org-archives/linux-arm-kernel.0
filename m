From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 21 Oct 2014 15:58:41 +0200
Subject: [PATCH v6 2/2] mtd: nand: add sunxi NFC dt bindings doc
In-Reply-To: <62d54110-9c7f-4342-9201-a1ae23194620@googlegroups.com>
References: <1413805520-14947-1-git-send-email-boris.brezillon@free-electrons.com>
 <1413805520-14947-3-git-send-email-boris.brezillon@free-electrons.com>
 <20141021024134.GC1193@ld-irv-0074>
 <20141021145344.575b19e6@bbrezillon>
 <62d54110-9c7f-4342-9201-a1ae23194620@googlegroups.com>
Message-ID: <20141021155841.180861d0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Oct 2014 06:13:16 -0700 (PDT)
Ezaul Zillmer <ezaulzillmer@gmail.com> wrote:

> Hello everyone 
> 
> Boris Brezillon 
> 
> downloaded sunxi-nand-v6 now compiled for Cubieboard2 
> https://github.com/bbrezillon/linux-sunxi.git sunxi b-nand-v6 
> 
> u-boot 
> git clone https://github.com/jwrdegoede/u-boot-b sunxi.git sunxi-wip 
> 
> 
> [1.143903] nand: Could not find valid JEDEC parameter page; aborting 
> [1.150369] nand: device found, Manufacturer ID: 0xec, Chip ID: 0xd7 
> [1.156766] nand: Samsung NAND 4GiB 3.3V 8-bit 
> [1.161214] nand: 4096MiB, MLC, page size: 8192, OOB size: 640 
> [1.167167] sunxi_nand 1c03000.nand: ECC init failed: -22 
> [1.172588] sunxi_nand 1c03000.nand: failed to init nand chips 
> [1.178502] sunxi_nand: probe of 1c03000.nand failed with error -22 
> 
> need some more data?
> 

Can you try to apply this patch [1] ?

[1]http://code.bulix.org/26bi35-87234



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
