From: wdgvip@gmail.com (daoguang wu)
Date: Mon, 27 Jun 2011 10:15:05 +0800
Subject: [PATCH] INPUT:Add ABS_PRESSURE input event support for
	touchscreen driver
In-Reply-To: <20110624124154.GC19804@sirena.org.uk>
References: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
	<20110624124154.GC19804@sirena.org.uk>
Message-ID: <BANLkTi=O44wyaFB_B83LGiQhAVtFOp64pyhMaCKCf_YZz6b1GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jun 24, 2011 at 10:15:38AM +0800, Wu DaoGuang wrote:
>> The touchscreen driver s3c2410_ts.c doesn't work well when using
>> the tslib, an abstraction layer for touchscreen panel events.
>> Tslib needs ABS_X ABS_Y and ABS_PRESSURE events to report, but only
>> the former two the driver can provide.
>
> It seems much more sane to fix this in tslib, the kernel is not actually
> reporting pressure meaningfully here and there's already BTN_TOUCH to
> report if the pen is down.
>
yeah,I will try to fix it in tslib.
Thanks a lot.
