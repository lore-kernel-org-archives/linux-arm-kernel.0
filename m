From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 17:52:19 +0200
Subject: [PATCH 00/12] at91: 3.4-rc3 fixes
In-Reply-To: <201204161540.08389.arnd@arndb.de>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
 <201204161540.08389.arnd@arndb.de>
Message-ID: <4F8C4033.2050600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 05:40 PM, Arnd Bergmann :
> On Monday 16 April 2012, Nicolas Ferre wrote:
>> Here is another fixes series for AT91 that will go on top of 3.4-rc3.
>> We experienced some issues while compiling some drivers as modules: Joachim has
>> corrected several of them. We may reduce this number of exported values by
>> reworking some drivers, in the future.
>> Some drivers are also modified here, I would like to keep them in the series
>> as the modifications are really related with our recent move to irqdomains or
>> simply related with compiler annotations.
> 
> I looked at all the patches, they look good to me, but patch 9 does not
> seem to be an actual bug-fix rather than a cleanup, so you might want
> to put that into a different series.

Yes, it is dead code that can go in a cleanup series for 3.5...

I can remove it and build a "pull request" tomorrow.

Thanks for this review Arnd.

Cheers,
-- 
Nicolas Ferre
