From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 03:24:44 +0200
Subject: [PATCH v4 09/28] tty: serial: Add Actions Semi Owl UART earlycon
In-Reply-To: <20170619011627.GB11287@kroah.com>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-10-afaerber@suse.de>
 <55059fdd-5c54-ee6c-3e63-b5a9035c1745@suse.de>
 <20170619011627.GB11287@kroah.com>
Message-ID: <7fff8813-cea4-0530-bf7b-3d0ad50d6e93@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.06.2017 um 03:16 schrieb Greg Kroah-Hartman:
> On Sun, Jun 18, 2017 at 11:45:28PM +0200, Andreas F?rber wrote:
>> Greg,
>>
>> Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
>>> This implements an earlycon for Actions Semi S500/S900 SoCs.
>>>
>>> Based on LeMaker linux-actions tree.
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>
>> The DT vendor prefix is applied to my linux-actions.git tree now, and
>> the serial binding has been ack'ed by Rob.
>>
>> Is there anything keeping you from adding this patch, the preceding DT
>> binding (08/28) and the following documentation patch (10/28) to your
>> tree for 4.13?
> 
> Yeah, I don't have it in my queue anymore :)
> 
> Can you resend it just as a single patch?

Do you mean squash the documentation into this tty patch? As you wish.
But the DT binding is supposed to be a separate patch - I can queue it
in my tree if you prefer.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
