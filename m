From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Wed, 27 Feb 2013 11:32:39 +0000
Subject: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
In-Reply-To: <512DC65D.7080603@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
 <512DC65D.7080603@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA47FEF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 14:09:57, Nori, Sekhar wrote:
> On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> > Patch enables support for m25p80 SPI flash support on
> > da850-EVM.
> > 
> > Testing information:
> > da850-evm comes with partitions specified in DT blob.
> > Able to mount/umount and create/delete files on filesystem partition.
> > 
> > Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> > "spi/davinci: add OF support for the spi controller"
> > 

Grant,
I could not find binding documentation changes submitted with above patch.
I checked in spi-next and linux-next.

> > Applies on top of below patch under community review:
> > http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg25184.html
> 
> The series looks good to me except a minor comment I gave on 4/4. Patch
> 1/4 should be picked by Grant (ideally before v3.9-rc1). I will queue
> rest of patches for v3.10.
> 

Thanks for review Sekhar, I will put your Acked-by for 1/4 for v2 of this series.

Regards,
Prakash
