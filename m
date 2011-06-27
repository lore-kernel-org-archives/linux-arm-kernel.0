From: wdgvip@gmail.com (daoguang wu)
Date: Mon, 27 Jun 2011 16:57:48 +0800
Subject: [PATCH] INPUT:Add ABS_PRESSURE input event support for
	touchscreen driver
In-Reply-To: <a8885a55-bf77-43d7-8491-045137aa38ee@email.android.com>
References: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
	<20110624124154.GC19804@sirena.org.uk>
	<BANLkTi=O44wyaFB_B83LGiQhAVtFOp64pyhMaCKCf_YZz6b1GA@mail.gmail.com>
	<5EB3BFCD089AD643B9BB63439F5FD5E937BB882D@SHAASIEXM01.ASIA.ROOT.PRI>
	<a8885a55-bf77-43d7-8491-045137aa38ee@email.android.com>
Message-ID: <BANLkTi=wU04jiOE-5GDDG9Pd4PgVnN61bTkqGfnkShHKo7iVFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/27 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>
>
> Baohua Song <Baohua.Song@csr.com> wrote:
>
>>
>>
>>> -----Original Message-----
>>> From: linux-arm-kernel-bounces at lists.infradead.org
>>> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
>>daoguang
>>> wu
>>> Sent: 2011?6?27? 10:15
>>> To: Mark Brown
>>> Cc: kgene.kim at samsung.com; ben-linux at fluff.org;
>>> dmitry.torokhov at gmail.com; linux-kernel at vger.kernel.org;
>>> wdgvip at gamil.com; linux-input at vger.kernel.org;
>>> linux-arm-kernel at lists.infradead.org
>>> Subject: Re: [PATCH] INPUT:Add ABS_PRESSURE input event support for
>>> touchscreen driver
>>>
>>> 2011/6/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>>> > On Fri, Jun 24, 2011 at 10:15:38AM +0800, Wu DaoGuang wrote:
>>> >> The touchscreen driver s3c2410_ts.c doesn't work well when using
>>> >> the tslib, an abstraction layer for touchscreen panel events.
>>> >> Tslib needs ABS_X ABS_Y and ABS_PRESSURE events to report, but
>>only
>>> >> the former two the driver can provide.
>>> >
>>> > It seems much more sane to fix this in tslib, the kernel is not
>>actually
>>> > reporting pressure meaningfully here and there's already BTN_TOUCH
>>to
>>> > report if the pen is down.
>>> >
>>> yeah,I will try to fix it in tslib.
>>
>>You may send a patch to tslib.
>>
>
> This has already been fixed in tslib a couple years ago. I'm not sure if a
> new version was cut or not.
> --
> Dmitry

I try the latest tslib ,and find there is no such problem and the
latest version of tslib  can be downloaded from
git://github.com/kergoth/tslib.git.

Thanks a lot.
