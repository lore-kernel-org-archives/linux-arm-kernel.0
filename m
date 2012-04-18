From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2012 23:57:20 +0530
Subject: [PATCH] ARM: davinci: mark spi_board_info arg to
 da8xx_register_spi as const
In-Reply-To: <20120418173345.GA20039@pengutronix.de>
References: <1333138433-14637-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <4F8EEADF.60505@ti.com> <20120418173345.GA20039@pengutronix.de>
Message-ID: <4F8F0788.50600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/18/2012 11:03 PM, Uwe Kleine-K?nig wrote:
> Hi Sekhar,
> 
> On Wed, Apr 18, 2012 at 09:55:03PM +0530, Sekhar Nori wrote:
>> On 3/31/2012 1:43 AM, Uwe Kleine-K?nig wrote:
>>> No further changes necessary
>>>
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Thanks for the patch. I extended this to include some other spi
>> registration routines being used for DM355 and DM365. Here is the
>> updated patch. Can you see if this is OK.
> apart from being exchange-or-outlook-scrambled it looks ok. But actually
> checking that the compiler doesn't yield any new warnings would be a
> better check ...

Hmm, I actually used Thunderbird; but sorry about the scrambling. Yes, I
did check for new warnings.

> 
>> Also, please also Cc davinci-linux-open-source at linux.davincidsp.com on
>> davinci patches.
> I asked get_maintainer.pl who to Cc (and cut the list down a bit). Maybe
> get_maintainer.pl doesn't include
> davinci-linux-open-source at linux.davincidsp.com because it's
> subscribers-only?

This should be fixed with the v3.4 kernel as the list is now marked as
"moderated". Can you try with the latest kernel?

Thanks,
Sekhar
