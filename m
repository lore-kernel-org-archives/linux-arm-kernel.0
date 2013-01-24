From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 24 Jan 2013 11:44:04 +0100
Subject: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
In-Reply-To: <20130124101356.GA12933@pengutronix.de>
References: <1354743732-11581-1-git-send-email-manabian@gmail.com>
 <20121218060232.GL23971@game.jcrosoft.org>
 <20130124072714.GH8364@nekote.pengutronix.de> <5100E9A4.9020804@atmel.com>
 <20130124101356.GA12933@pengutronix.de>
Message-ID: <51011074.1020905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 11:13 AM, Wolfram Sang wrote:
> Hi,
>
>> I didn't add this when I did the rework because there was no DT tree
>> support for RM9200. The configuration for RM9200 IP is already in
>> the driver and used for non DT platform so I think it makes sense to
>> add this.
>
> I agree. If it is usable for non-dt, it should be usable for dt. If it
> makes sense is left to the user.
>
> Interpreted Ludovic's comment as ack and applied to -next, thanks!
>

Yes it is, thanks.

Regards

Ludovic
