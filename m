From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 25 Mar 2011 12:43:41 -0300
Subject: [PATCH v2 2/4] ARM: mx5/babbage: Use gpio_request_one in
	babbage_usbhub_reset
In-Reply-To: <20110317161047.GO13316@pengutronix.de>
References: <1300377359-23212-1-git-send-email-fabio.estevam@freescale.com>
	<1300377359-23212-2-git-send-email-fabio.estevam@freescale.com>
	<20110317161047.GO13316@pengutronix.de>
Message-ID: <4D8CB82D.2000405@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 3/17/2011 1:10 PM, Uwe Kleine-K?nig wrote:
> On Thu, Mar 17, 2011 at 12:55:57PM -0300, Fabio Estevam wrote:
>> Current code inside babbage_usbhub_reset uses gpio_direction_output with initial value of the GPIO and also sets 
>> the GPIO value via gpio_set_value to the same level right after. This is not needed. 
>>
>> By using gpio_request_one it is possible to set the direction and initial value in one shot.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

On your i.MX pull request of today I didn?t see this patch applied.

Is there any problem with this one?

Thanks,

Fabio Estevam
