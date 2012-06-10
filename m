From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Jun 2012 14:31:26 -0300
Subject: [PATCH] serial/imx: enable the clock when we really use the uart
 port
In-Reply-To: <20120502081902.GT4141@pengutronix.de>
References: <1335946770-17120-1-git-send-email-b32955@freescale.com>
 <20120502081902.GT4141@pengutronix.de>
Message-ID: <CAOMZO5DtC3yK7RgtbjefepQXk2jE+tODmivw+CC_hd5TCCe-oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huang,

On Wed, May 2, 2012 at 5:19 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, May 02, 2012 at 04:19:30PM +0800, Huang Shijie wrote:
>> The current code keeps the clock enabled even when we do not really
>> use the uart port. But keep the clock enabled will consume some power.
>>
>> In order to save more power, disable the clock when we do not use
>> the uart, and enable the clock when we really use the uart port.
>>
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>
> This conflicts with my series converting i.MX to the common clock
> framework. Please lets delay this until this has been merged.

I think it is OK to resubmit this patch now.
