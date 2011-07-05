From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 05 Jul 2011 14:51:08 +0900
Subject: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO
	level
In-Reply-To: <20110704150607.GA29977@ponder.secretlab.ca>
References: <BANLkTi=9c5asfr=Jg6xwjQZW_a369UO64Q@mail.gmail.com>
	<BANLkTinFnFwBGi693JTD_iDykA2VkV+HOw@mail.gmail.com>
	<BANLkTik0LERxBHmJc5ZnRotnD4CSveR-UQ@mail.gmail.com>
	<BANLkTim9wdrqDgXVUjxzMv9cdWViLww=Bg@mail.gmail.com>
	<BANLkTim40x4X_--K0z7gdodDjor0MUam5Q@mail.gmail.com>
	<BANLkTinf6ec1yXeaFkZjHMnqZp7yymDq-w@mail.gmail.com>
	<20110704065501.GP15152@ponder.secretlab.ca>
	<CACxGe6urrZ9=1OgcaYF6EtvJokAyFTbFCnHPWsCY+sETVze8-w@mail.gmail.com>
	<005501cc3a30$6c916190$45b424b0$%kim@samsung.com>
	<005601cc3a32$64bd5fd0$2e381f70$%kim@samsung.com>
	<20110704150607.GA29977@ponder.secretlab.ca>
Message-ID: <009f01cc3ad7$8e350200$aa9f0600$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> 
> On Mon, Jul 04, 2011 at 07:08:55PM +0900, Kukjin Kim wrote:
> > Kukjin Kim wrote:
> > >
> > > Thanks Grant, Jassi and all,
> > >
> > > I will apply these 1 and 2 in my -fix tree for 3.0 with your acks.
> > >
> > Oops, this needs previous 'cleanup spi platform specific code' so can't
> > apply -fix tree now.
> 
> There may also be conflicts with the heavy rework in the spi tree.
> Kgene, when you pick up this series, can you put it into a separate
> topic branch and merge that into your main tree?  That way if there
> are difficult conflicts, then I can also merge that same topic branch
> into spi/next to resolve them.
> 
Hi Grant,

Sure, no problem. I'm waiting for Padmavathi's new patch which is based on
old code not new SPI code. When I merge topic branch for this into my tree,
let you know immediately. Then if any problems, let's talk again :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
