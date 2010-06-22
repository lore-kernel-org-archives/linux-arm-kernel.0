From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 22 Jun 2010 14:05:12 +0900
Subject: Samsung SoCs naming rules
In-Reply-To: <AANLkTilnjN1dBWPKCuDt_bg8-5GEuSCrOh7vhqGf-VQU@mail.gmail.com>
References: <AANLkTiljyiQohHVJxUsn7Q6_IwTZk2AdNlLRxgGmxNpQ@mail.gmail.com>
	<AANLkTilnjN1dBWPKCuDt_bg8-5GEuSCrOh7vhqGf-VQU@mail.gmail.com>
Message-ID: <011201cb11c8$8236c530$86a44f90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> 
> On Mon, Jun 21, 2010 at 6:00 PM, Kyungmin Park <kmpark@infradead.org>
wrote:
> > Dear all,
> >
> > Now Samsung SoCs doesn't have any special rules include chip name.
> >
> > Historically s5pc100 is successor form s3c6410 and this chip from
> > s3c2410 series.
> > on the other hand, s5pc110 (cortex a8) and s5pc64xx (armv6) is
> > different from previous chips.
> 
> Don't be shy, Samsung is not the only vendor messes the naming of their
> SoCs. Marvell might have done a better job on this :-)
> 
> >
> > So it's not good idea grouping with the prefix. e.g., s5p series. and
> > the reason to create the samsung.
> >
> 
> My guess is your s5p will focus more on Cortex-A8 (or A9 possibly),
> even with subsequent processors. And only s5pc100 is an exception,
> that's fine, you can still put s5pc100 into mach-s3c6410, and people
> will know it's actually closer to s3c6410. And other SoCs will share the
> common s5p prefix.

Hi Eric,

Actually, S5P does not focus on only Cortex-A8 or -A9.
The S5P6440 and S5P6442 which have ARM11 core are S5P series in Samsung
SoCs, too.

Besides, other S5P SoC which has ARM11 core will be produced.

And S5PC100 is Cortex-A8 SoC, the architecture is different from S3C6410.

Please refer to below URLs.
http://www.samsung.com/global/business/semiconductor/productInfo.do?fmly_id=
835&partnum=S3C6410&xFmly_id=229
http://www.samsung.com/global/business/semiconductor/productInfo.do?fmly_id=
834&partnum=S5PC100&xFmly_id=229

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
