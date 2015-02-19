From: a.bouin@gmail.com (=?UTF-8?Q?aur=C3=A9lien_bouin?=)
Date: Thu, 19 Feb 2015 10:45:47 +0100
Subject: [PATCH 7/7] serial: imx: add support for half duplex rs485
In-Reply-To: <20150219093752.GO19388@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAFeThoCahCMGniG59k4Le3E-4P+TEi_7dxUagKWzc20WAvkMuA@mail.gmail.com>
 <20150219093752.GO19388@pengutronix.de>
Message-ID: <CAFeThoC2+SGc1ZgQhbBx-pxxzpRJ-61n_fs8BZo8ChFcti3Vqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I hope this link will be ok :
http://marc.info/?l=linux-kernel&m=142366865609389&q=raw
Best regards,



2015-02-19 10:37 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Aur?lien,
>
> On Thu, Feb 19, 2015 at 10:15:10AM +0100, aur?lien bouin wrote:
>> 2015-02-18 21:41 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > The transmitter is expected to be controlled by the UART's RTS pin.
>>
>> You definately can be more open in using the last patch I have sent
>> the 11th of februrary using rs485.padding[0] that give in parameter
>> the GPIO to use for transmit pin
> you have a link? Without having seen that patch this can well be a
> separate patch. And (also without having seen the patch) I wonder why
> the information which gpio to use doesn't come from the device tree but
> is supplied by userspace. I thought about expanding mctrl-gpio for that,
> but as there are a few conflicting patches to mctrl-gpio out I wanted to
> wait until the dust settles.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
