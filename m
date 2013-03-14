From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 14 Mar 2013 15:54:26 +0530
Subject: [PATCH v3 0/5] Enable SPI flash support on da850-evm DT kernel
In-Reply-To: <1363075827-31053-1-git-send-email-prakash.pm@ti.com>
References: <1363075827-31053-1-git-send-email-prakash.pm@ti.com>
Message-ID: <5141A55A.9060708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/12/2013 1:40 PM, Manjunathappa, Prakash wrote:
> Patch enables support for m25p64 SPI flash support on
> da850-EVM.

This patch set looks good to me except the comments I had on 2/5. I
tested it using SPI flash on DA850 EVM and it worked fine on basic
read/write tests.

Grant,

With your ack I would like to merge the series through DaVinci tree so
its easy to manage the conflicts in DT files.

> 
> Testing information:
> da850-evm comes with partitions specified in DT blob.
> Able to mount/umount and create/delete files on filesystem partition.
> 
> Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> "spi/davinci: add OF support for the spi controller"

Prakash, there is no need to mention this dependency. The patch is
already in mainline.

Thanks,
Sekhar
