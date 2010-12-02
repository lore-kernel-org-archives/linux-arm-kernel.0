From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 2 Dec 2010 19:15:23 +0800
Subject: [PATCH 2/2] make mc13783 regulator code generic
In-Reply-To: <20101202105701.GB26555@pengutronix.de>
References: <AANLkTi=E8etAOPTCBw8ccTZ9LMU-Yf=wELn+VQkg2eom@mail.gmail.com>
	<AANLkTim4TURXFb3g_L1jzU9S+Jic6OZp48uvAoZOh4+w@mail.gmail.com>
	<20101202105701.GB26555@pengutronix.de>
Message-ID: <AANLkTinqk5U3HJX6BoceXH=QG2QtW8oVUkdPoVZdcQ4m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I will resend them.

2010/12/2 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Thu, Dec 02, 2010 at 06:45:32PM +0800, Yong Shen wrote:
>> Hi there,
>>
>> Please give comments inline and use attached patch for testing.
>>
>> Thanks
>> Yong
>>
>>
>> From 377c680c35089aea7697397c42349189843eeaff Mon Sep 17 00:00:00 2001
>> From: Yong Shen <yong.shen@linaro.org>
>> Date: Thu, 2 Dec 2010 14:59:00 +0800
>> Subject: [PATCH 2/2] make mc13783 regulator code generic
>>
>> move some common functions and micros of mc13783 regulaor driver to
> s/micros/macros/ s/regulaor/regulator/
>
>> a seperate file, which makes it possible for mc13892 to share code.
> s/seperate/separate/
>
> (Note I havn't looked at the patch)
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
