From: rogerq@ti.com (Roger Quadros)
Date: Wed, 7 Oct 2015 14:07:45 +0300
Subject: [PATCH 2/2] memory: omap-gpmc: expand the description of the
 debug facility
In-Reply-To: <20151007110231.GL3982@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com> <20151007075338.GH3982@pengutronix.de>
 <20151007102822.GT23801@atomide.com> <20151007110231.GL3982@pengutronix.de>
Message-ID: <5614FD01.6090009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 14:02, Uwe Kleine-K?nig wrote:
> Hello Tony,
> 
> On Wed, Oct 07, 2015 at 03:41:19AM -0700, Tony Lindgren wrote:
>> * Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [151007 00:57]:
>>> On Wed, Oct 07, 2015 at 10:45:50AM +0300, Roger Quadros wrote:
>>>>
>>>> How about this instead?
>>>>
>>>> NOTE: Apart from matching the register setup with the bootloader you also need to
>>>> match the GPMC FCLK frequency used by the bootloader else the GPMC timings
>>>> won't be identical with the bootloader timings.
>>> Yeah, sounds better, thanks.
>>>
>>>> Also you might need to build this patch on top of
>>>> http://article.gmane.org/gmane.linux.kernel/2054796
>>> I talked to Tony about this patch yesterday on irc, but I didn't find it
>>> in the archives yet when I sent my mail.
>>
>> Yes sorry here's a repost with your and Roger's changes folded in and
>> edited a bit. Probably best to keep them together with this patch.
>>
>> Does the following look OK to you guys?
> Yes,
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Looks good to me too.

cheers,
-roger
