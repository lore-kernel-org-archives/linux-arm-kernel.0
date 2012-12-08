From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 8 Dec 2012 17:45:28 -0200
Subject: [PATCH v2] ARM: eukrea_mbimx27-baseboard - use stock
 get_pendown_state() in ads7846
In-Reply-To: <20121208111629.GG10369@pengutronix.de>
References: <20121124082529.GA7687@core.coreip.homeip.net>
 <20121127074209.GL10369@pengutronix.de>
 <20121127090356.GA25658@core.coreip.homeip.net>
 <20121208111629.GG10369@pengutronix.de>
Message-ID: <CAOMZO5B8UXt+tBg7S1A=sBPQB-tCjVjARfDzNmEV8_m5a-qg0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Sat, Dec 8, 2012 at 9:16 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Nov 27, 2012 at 01:03:56AM -0800, Dmitry Torokhov wrote:
>> The default implementation matches exactly our custom one so we can switch
>> to using the default one. As a bonus the driver will take care of setting
>> GPIO line for us.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Applied, thanks

Which tree did you apply this against? I cannot see it in git.pengutronix.de.

Regards,

Fabio Estevam
