From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 26 Nov 2010 21:07:46 +0100
Subject: [PATCH 28/51] ARM: mx25: dynamically allocate mxc-ehci devices
In-Reply-To: <4CEFD139.8090600@gandalf.sssup.it>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<4CEFCC9A.2020500@fqingenieria.es>
	<4CEFD139.8090600@gandalf.sssup.it>
Message-ID: <20101126200746.GB25293@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Fri, Nov 26, 2010 at 04:24:41PM +0100, Michael Trimarchi wrote:
> On 11/26/2010 04:04 PM, Jaume Ribot wrote:
>> Dear Uwe,
>>
>> I think there is an error in the Freescale documentation, as new 0x200 offset (as it might be according reference manual) makes usbh2 stops working.
>>
>> Other users have experienced simmilar issues:
>> http://forums.freescale.com/t5/i-MX-Microprocessors/i-MX25-USBOH-host-core-port-on-chip-serial-PHY-Control/m-p/59365
>>
>> I think old 0x400 offset value were correct.
>> Anyone can confirm?
> I can say that I'm using the mainline (814ce2521121c2459e16cea8c7221e157edbeddd) without this patch and the usbhost work
> on my mx25 board.
And I assume applying the patch breaks USB for you?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
