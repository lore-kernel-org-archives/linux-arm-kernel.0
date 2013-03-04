From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 4 Mar 2013 13:08:37 +0000
Subject: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
In-Reply-To: <20130302231355.5CD2D3E34C9@localhost>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
 <512DC65D.7080603@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA47FEF@DBDE01.ent.ti.com>
 <20130302231355.5CD2D3E34C9@localhost>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48401@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Sun, Mar 03, 2013 at 04:43:55, Grant Likely wrote:
> On Wed, 27 Feb 2013 11:32:39 +0000, "Manjunathappa, Prakash" <prakash.pm@ti.com> wrote:
> > On Wed, Feb 27, 2013 at 14:09:57, Nori, Sekhar wrote:
> > > On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> > > > Patch enables support for m25p80 SPI flash support on
> > > > da850-EVM.
> > > > 
> > > > Testing information:
> > > > da850-evm comes with partitions specified in DT blob.
> > > > Able to mount/umount and create/delete files on filesystem partition.
> > > > 
> > > > Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> > > > "spi/davinci: add OF support for the spi controller"
> > > > 
> > 
> > Grant,
> > I could not find binding documentation changes submitted with above patch.
> > I checked in spi-next and linux-next.
> 
> It must have been missed then. It happens sometimes. Can someone submit
> a fixup patch please?
> 

I have taken care in my next version of this series.

Thanks,
Prakash
