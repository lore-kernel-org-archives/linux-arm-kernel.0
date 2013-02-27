From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Feb 2013 14:09:57 +0530
Subject: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
In-Reply-To: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
Message-ID: <512DC65D.7080603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> Patch enables support for m25p80 SPI flash support on
> da850-EVM.
> 
> Testing information:
> da850-evm comes with partitions specified in DT blob.
> Able to mount/umount and create/delete files on filesystem partition.
> 
> Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> "spi/davinci: add OF support for the spi controller"
> 
> Applies on top of below patch under community review:
> http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg25184.html

The series looks good to me except a minor comment I gave on 4/4. Patch
1/4 should be picked by Grant (ideally before v3.9-rc1). I will queue
rest of patches for v3.10.

Thanks,
Sekhar
