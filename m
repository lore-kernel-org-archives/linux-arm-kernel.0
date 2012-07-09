From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Mon, 09 Jul 2012 09:41:27 +0900
Subject: [PATCH 0/3] hwspinlock: a bug fix, trivial changes
In-Reply-To: <CAK=WgbYgVoB+B3P6NLpd2t=F9PVA_m7Nbou4k1aq8BGvjJhvNg@mail.gmail.com>
References: <4FF66FBD.5090601@renesas.com>
 <CAK=WgbYgVoB+B3P6NLpd2t=F9PVA_m7Nbou4k1aq8BGvjJhvNg@mail.gmail.com>
Message-ID: <4FFA28B7.9090705@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 7/7/2012 7:59 PM, Ohad Ben-Cohen wrote:
>> Recently I wrote a hwspinlock driver for our devices
> 
> Great! looking forward to see it :)

Unfortunately I'm not planning to submit that driver at the moment,
as I'm 120% sure that it won't be utilized by any module in our BSPs
in the mainline kernel.

>> and during
>> the review and debug process, we found a bug in the core code.
>> Could you take a look please?
> 
> I looked and it's great. Will send to Linus soon.

Thanks for fixing up the error path I msised.

>> The first patch is a bug fix.  The latter two patches are what I
>> think nice-to-have.  If you find useful, just take it, thanks!
> 
> I commented on the latter two (generally both look ok sans a small
> outstanding comment).

Thanks, but I don't mind you dropping the latter two, either.  If I
have a chance to revisit hwspinlock drivers, I'll go through patches
again with your comments in mind.

-- 
Shinya Kuribayashi
Renesas Electronics
