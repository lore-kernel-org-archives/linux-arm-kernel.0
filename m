From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 18 May 2011 12:05:08 +0300
Subject: [RESEND PATCH 1/4] omap: igep0020: name refactoring for future
	merge with IGEP3
In-Reply-To: <20110517103352.GB27250@atomide.com>
References: <cover.1305235542.git.mike@compulab.co.il>	<d6dc9e334c729523f25993b7d610808e537ca74c.1305235542.git.mike@compulab.co.il>	<BANLkTikJaN=Q2RgrA7Hz-ye2BCOjNK42zA@mail.gmail.com>	<20110517075345.GQ5323@atomide.com>	<BANLkTikCgWxQoiYfS4O4+9jYCVBmcMAEOQ@mail.gmail.com>
	<20110517103352.GB27250@atomide.com>
Message-ID: <4DD38BC4.6080905@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/11 13:33, Tony Lindgren wrote:

> * Enric Balletb? i Serra <eballetbo@gmail.com> [110517 00:53]:
>> Hi,
>>
>> 2011/5/17 Tony Lindgren <tony@atomide.com>:
>>> * Enric Balletb? i Serra <eballetbo@gmail.com> [110516 10:11]:
>>>> Hi Mike,
>>>>
>>>> The only comment I wanted to do is maybe I prefer rename the
>>>> board-igep0020 to board-igep00x0 to be more generic. Apart from this
>>>> these patch series looks good for me and has my ack. Thanks.
>>> I suggest we do the rename separately later on. Otherwise it
>>> easily gets classified as "crazy churn" type of patch, so best
>>> to stick to just code coalescing and fixes for this merge window.
>> Ok, so Mike you've my ack, thanks
> Thanks, applying these to devel-cleanup for the upcoming merge
> window.

You mean for-next? Or you've just forgot to update the devel-cleanup?


-- 
Regards,
Igor.
