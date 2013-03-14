From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 14 Mar 2013 13:42:19 +0000
Subject: [PATCH v3 0/5] Enable SPI flash support on da850-evm DT kernel
In-Reply-To: <5141A55A.9060708@ti.com>
References: <1363075827-31053-1-git-send-email-prakash.pm@ti.com>
 <5141A55A.9060708@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48F1B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 15:54:26, Nori, Sekhar wrote:
> On 3/12/2013 1:40 PM, Manjunathappa, Prakash wrote:
> > Patch enables support for m25p64 SPI flash support on
> > da850-EVM.
> 
> This patch set looks good to me except the comments I had on 2/5. I
> tested it using SPI flash on DA850 EVM and it worked fine on basic
> read/write tests.
> 

Thanks I will add your Reviewed-by.

> Grant,
> 
> With your ack I would like to merge the series through DaVinci tree so
> its easy to manage the conflicts in DT files.
> 
> > 
> > Testing information:
> > da850-evm comes with partitions specified in DT blob.
> > Able to mount/umount and create/delete files on filesystem partition.
> > 
> > Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> > "spi/davinci: add OF support for the spi controller"
> 
> Prakash, there is no need to mention this dependency. The patch is
> already in mainline.
> 

Yes, I mentioned it here as my patches were based on linux-davinci: v3.9/dt-2 branch.
Will rebase my next versions on davinci/master.

Thanks,
Prakash
