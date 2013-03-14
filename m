From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 14 Mar 2013 13:52:19 +0000
Subject: [PATCH v5 0/4] Add DT support for davinci_mmc driver
In-Reply-To: <5141BAA1.1070906@ti.com>
References: <1363097637-11371-1-git-send-email-prakash.pm@ti.com>
 <5141BAA1.1070906@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48F4D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 17:25:13, Nori, Sekhar wrote:
> On 3/12/2013 7:43 PM, Manjunathappa, Prakash wrote:
> > Patch set adds DT support for davinci_mmc driver and is
> > verified on da850-evm without card_detect/write_protect and
> > EDMA support. Also takecare to derive controller IP version from
> > platform_device_id table, remove version specification in pdata.
> > 
> > Applies on top of below patch under community review:
> > "Enable SPI flash support on da850-evm DT kernel"
> > http://www.spinics.net/lists/arm-kernel/msg229328.html
> > 
> > Depends on patch waiting for acceptance:
> > Patch "mmc: davinci: allow driver to work without DMA resource"
> > http://www.mail-archive.com/linux-mmc at vger.kernel.org/msg18771.html
> 
> Since this patch did not get picked for v3.9, it may be worthwhile
> rebasing it and adding to this series.
> 

Will do that.

Thanks,
Prakash 
