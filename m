From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 21 Apr 2015 13:46:51 +0200
Subject: [PATCH] soc: mediatek: Fix off-by-one checking for rate_spi
In-Reply-To: <20150421105953.GY6325@pengutronix.de>
References: <1429613612.5644.1.camel@ingics.com>
 <20150421105953.GY6325@pengutronix.de>
Message-ID: <CABuKBeL+YTZz4jkMwozm4SbtP_4N8kBiqgeEHh1htoK6StpK_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

2015-04-21 12:59 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, Apr 21, 2015 at 06:53:32PM +0800, Axel Lin wrote:
>> If rate_spi is 26000000, current code set ck_mhz to 18 rather than 26.
>> Fix the off-by-one checking for rate_spi.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>

Can you please explain why you think this is a bug? Please see my
concerns here [1].

Best regards,
Matthias

[1] http://lists.infradead.org/pipermail/linux-mediatek/2015-April/000419.html
