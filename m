From: khilman@ti.com (Kevin Hilman)
Date: Fri, 13 May 2011 14:21:22 +0200
Subject: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing
	preprocessor.
In-Reply-To: <20110513113013.GP31483@atomide.com> (Tony Lindgren's message of
	"Fri, 13 May 2011 04:30:13 -0700")
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
	<20110513113013.GP31483@atomide.com>
Message-ID: <87r582g5a5.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Vladimir Zapolskiy <vzapolskiy@gmail.com> [110512 17:35]:
>> This mass change reduces homogeneous data chunks along clock
>> definitions. No semantical difference is added to the change,
>> and still it could be introduced easily.
>> 
>> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
>> ---
>>  arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
>>  1 files changed, 848 insertions(+), 2465 deletions(-)
>
> Hehehe, the diffstat certainly looks good :)
>
> This would be best done for all of them using some
> perl/sed/python script. And could be done for the hwmod data
> too. Do you already have something like that available?
>
> Paul and & Benoit, what's your take on doing something like
> this? I'd assume updating your data generation scripts would
> be trivial?

Can this be reposted to the list?  I didn't receive the original, and
don't see it in the l-o or l-a-k archives.

Thanks,

Kevin
