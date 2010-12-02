From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 2 Dec 2010 13:46:22 +0800
Subject: [PATCH] add clock debug information for imx51 babbage
In-Reply-To: <20101201145719.GG32355@pengutronix.de>
References: <AANLkTi=cTYjaDh0Zd-7joLCycMcLoPW+Ekws=46QMoDc@mail.gmail.com>
	<20101201145719.GG32355@pengutronix.de>
Message-ID: <AANLkTi=EoC2gz4i8+a-7EaB9TEEVEyNkTGEn9WefiLNb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2010/12/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
>> +
>> +config CLK_DEBUG
>> + ? ? bool "clock debug information export to user space"
>> + ? ? depends on PM_DEBUG && DEBUG_FS
>> + ? ? default n
> You can skip that "default n" as it's the default.
Acked.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
