From: padma.kvr@gmail.com (padma venkat)
Date: Thu, 17 Nov 2011 07:11:08 +0530
Subject: [PATCH 6/6] ARM: S3C64XX: Modified according to SPI consolidation
 work.
In-Reply-To: <003401cca365$74c25920$5e470b60$%kim@samsung.com>
References: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
 <1320410634-10788-7-git-send-email-padma.v@samsung.com>
 <20111104105710.GA12134@opensource.wolfsonmicro.com>
 <CAAgF-Bcj3vm50YOU4Sq4cGrOE8EHixjOuFrQq-MR6FVLf7Dekg@mail.gmail.com>
 <003401cca365$74c25920$5e470b60$%kim@samsung.com>
Message-ID: <CAAgF-Bdt0zuGNLGq8D=-26v_8WZi6Ley=iCG7j-N03G9k+3WKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tue, Nov 15, 2011 at 12:39 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> padma venkat wrote:
>
>> Hi Mark,
>> On Fri, Nov 4, 2011 at 4:27 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Fri, Nov 04, 2011 at 08:43:54AM -0400, Padmavathi Venna wrote:
>>
>> > +#ifdef CONFIG_S3C64XX_DEV_SPI0
>> > +static struct s3c64xx_spi_info crag6410_spi0_pdata __initdata = {
>> > + ? ? .cfg_gpio ? ? ? = s3c64xx_spi0_cfg_gpio,
>> > + ? ? .fifo_lvl_mask ?= 0x7f,
>> > + ? ? .rx_lvl_offset ?= 13,
>> > + ? ? .tx_st_done ? ? = 21,
>> > +};
>> > +#endif
>> It seems like a step backwards to have all this stuff in the individual
>> machines - most of this (everything except cfg_gpio pretty much) is a
>> property of the SoC silicon so should be somewhere central for the SoC.
>> I Will?move this stuff to SPI setup files and resend the patches.
>> Thanks
>> Padma
>
> Hi Padma,
>
> Please send text-typed e-mail when you reply :)
Okey.
>
> And I agree with Mark, how was going on?
I will send the patches by tomorrow.
Thanks&Regards
Padma
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
