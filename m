From: b32955@freescale.com (Huang Shijie)
Date: Mon, 11 Jun 2012 10:13:31 +0800
Subject: [PATCH] serial/imx: enable the clock when we really use the uart
 port
In-Reply-To: <CAOMZO5DtC3yK7RgtbjefepQXk2jE+tODmivw+CC_hd5TCCe-oA@mail.gmail.com>
References: <1335946770-17120-1-git-send-email-b32955@freescale.com>	<20120502081902.GT4141@pengutronix.de>
 <CAOMZO5DtC3yK7RgtbjefepQXk2jE+tODmivw+CC_hd5TCCe-oA@mail.gmail.com>
Message-ID: <4FD5544B.5090200@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?06?11? 01:31, Fabio Estevam ??:
> Huang,
>
> On Wed, May 2, 2012 at 5:19 AM, Sascha Hauer<s.hauer@pengutronix.de>  wrote:
>> On Wed, May 02, 2012 at 04:19:30PM +0800, Huang Shijie wrote:
>>> The current code keeps the clock enabled even when we do not really
>>> use the uart port. But keep the clock enabled will consume some power.
>>>
>>> In order to save more power, disable the clock when we do not use
>>> the uart, and enable the clock when we really use the uart port.
>>>
>>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> This conflicts with my series converting i.MX to the common clock
>> framework. Please lets delay this until this has been merged.
> I think it is OK to resubmit this patch now.
>
ok, thanks.

Huang Shijie
