From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 26 Nov 2014 18:31:22 +0200
Subject: [PATCH v2 2/5] i2c: davinci: query STP always when NACK is
 received
In-Reply-To: <20141126155711.GL4431@pengutronix.de>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-3-git-send-email-grygorii.strashko@ti.com>
 <20141126155711.GL4431@pengutronix.de>
Message-ID: <5476005A.6090207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 05:57 PM, Uwe Kleine-K?nig wrote:
> Hello,
>
> I don't understand your use of "query" in the subject and later in the
> commit log. Do you mean "send"?

will change to "generate". Ok?

>
> On Wed, Nov 26, 2014 at 03:59:50PM +0200, Grygorii Strashko wrote:
>> According to I2C specification the NACK should be handled as folows:
> s/folows/follows/
ok.

Can I assume that you are ok with this patch in general?

regards,
-grygorii
