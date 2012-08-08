From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 08 Aug 2012 11:08:54 +0900
Subject: =?ks_c_5601-1987?B?UkU6IMi4vcU6IFtQQVRDSCAyLzRdIGFybS9kdHM6IGV4eQ==?=
 =?ks_c_5601-1987?B?bm9zNDogQWRkIERUUyBmaWxlcyBkZXJpdmVkIGZyb20gYw==?=
 =?ks_c_5601-1987?B?b21tb24gRXh5bm9zNA==?=
In-Reply-To: <201208072029.08693.arnd@arndb.de>
References: <1344366398-19022-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <201208071938.26507.arnd@arndb.de>
 <A6A3B7488C419F488E5B13FFD03C08AD2F4372EB@SN2PRD0510MB370.namprd05.prod.outlook.com>
 <201208072029.08693.arnd@arndb.de>
Message-ID: <0a3a01cd750a$c2e6a2b0$48b3e810$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Tuesday 07 August 2012, Dongjin Kim wrote:
> > Hi,
> >
> > I didn't use -M and I couldn't see any difference with the it.
> > Did I make something wrong on that patch?
> 
> No, I think it's just git being less smart about file moves than I was
> hoping
> for. It might do the right thing if you do the patch in two steps:
> 
Yeah, in this case, git does not work just as we expected :-(

> 1. rename exynos4210.dtsi to exynos4.dtsi and add a one-line
> exynos4210.dtsi
> file that just includes exynos4.dtsi.
> 
> 2. do all the changes for moving contents back from exynos4.dtsi into
> exynos4210.dtsi and exynos4412.dtsi.
> 
> Not sure if it's worth it though.

Hehehe, but I did with separated commit as per your comment and it was ok,
then squashed, same...uhm...I think, we don't need to keep two commits
here...

> Your version is probably good enough
> if there are no tools to do a better job automatically.
> 
I agree with Arnd's opinion and I will review in detail soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
