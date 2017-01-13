From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Fri, 13 Jan 2017 10:36:01 +0100
Subject: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <20170113084513.wvuxkanrlmgz3ang@pengutronix.de>
References: <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
 <20170112120309.fmrt2lwz3vklqmti@pengutronix.de>
 <CAOAejn289GLOSP-nPJnO_VpXLpyhTsF1bWQ7Ns9OfgPQCa8YTw@mail.gmail.com>
 <20170112174902.j52foglkdouyz36n@pengutronix.de>
 <CAOAejn3tPi0fjy+t-UhMTvAq7LfdKJJdbcLw2su1-YAGDZMxew@mail.gmail.com>
 <20170112211004.z3wylc7vrubulc3x@pengutronix.de>
 <CAOAejn1HAU5spQeXmYPH4XH0L5bGuoFgguozwMp=uLKcXDEPEw@mail.gmail.com>
 <20170113072650.orx6vl2orqfakcuk@pengutronix.de>
 <20170113082903.GA1446@katana>
 <20170113084513.wvuxkanrlmgz3ang@pengutronix.de>
Message-ID: <CAOAejn0c+G7LeZS-_Yq3yM=Y7LG=_vr+0-UYqmCZTyM1q4GmRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok so I am going to send the v9 asap.
Thanks

2017-01-13 9:45 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Fri, Jan 13, 2017 at 09:29:03AM +0100, Wolfram Sang wrote:
>>
>> > (But note that this is irrelevant for the patch as the driver doesn't
>> > claim to support this kind of transfer.)
>>
>> Yes, I wanted to mention that, too.
>>
>> I'd think the series is good to go in?
>
> AFAICT there are some unaddressed comments that Cedrics claimed to fix
> before our discussion was dominated by block transfers.
>
> Best regards
> Uwe
>
>
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
