From: jaume@fqingenieria.es (jaume at fqingenieria.es)
Date: Mon, 29 Nov 2010 08:40:31 +0100 (CET)
Subject: [PATCH 28/51] ARM: mx25: dynamically allocate mxc-ehci devices
In-Reply-To: <AANLkTik53KX4Ni3Vd7MNpXnxp_c6U=CD_tzJ+7ycEsQ5@mail.gmail.com>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<4CEFCC9A.2020500@fqingenieria.es>
	<20101126194831.GA25293@pengutronix.de>
	<AANLkTik53KX4Ni3Vd7MNpXnxp_c6U=CD_tzJ+7ycEsQ5@mail.gmail.com>
Message-ID: <45981.212.121.242.58.1291016431.squirrel@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for previous email. I have missed reading this response. Now this
point it's clear.

Regards.

> Hi Uwe,
>
> 2010/11/27 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> Hello Jaume,
>>
>> On Fri, Nov 26, 2010 at 04:04:58PM +0100, Jaume Ribot wrote:
>>> Dear Uwe,
>>>
>>> I think there is an error in the Freescale documentation, as new 0x200
>>> offset (as it might be according reference manual) makes usbh2 stops
>>> working.
>>>
>>> Other users have experienced simmilar issues:
>>> http://forums.freescale.com/t5/i-MX-Microprocessors/i-MX25-USBOH-host-core-port-on-chip-serial-PHY-Control/m-p/59365
>>>
>>> I think old 0x400 offset value were correct.
>>> Anyone can confirm?
>> Maybe one of the Freescale guys? ?(Added to Cc:)
>>
> I confirmed it with i.MX25 design team that offset 0x400 is the
> correct one, and 0x200 will not work.  I will ping documentation team
> to get this document error fixed.
>
> --
> Regards,
> Shawn
>
