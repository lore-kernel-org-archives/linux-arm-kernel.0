From: vapier.adi@gmail.com (Mike Frysinger)
Date: Thu, 10 Mar 2011 20:34:31 -0500
Subject: [PATCH] kbuild: reenable section mismatch analysis
In-Reply-To: <20110310170508.1a3d431d.akpm@linux-foundation.org>
References: <20110216200734.GA25184@merkur.ravnborg.org>
	<1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110310164100.5af81e3b.akpm@linux-foundation.org>
	<AANLkTik7HwLs8Ux=THRy_-ByH4adebHodSLeEgSSqcsH@mail.gmail.com>
	<20110310170508.1a3d431d.akpm@linux-foundation.org>
Message-ID: <AANLkTikVi7M8+ys1KaQH9JdR8xP_G1KaadbNHgxspe2D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 20:05, Andrew Morton wrote:
> On Thu, 10 Mar 2011 20:00:54 -0500 Mike Frysinger wrote:
>> > eaaaargh! __650 lines of crap added to my i386 allmodconfig build output.
>>
>> and it's going to keep staying all f-ed up until people start seeing
>> this stuff themselves when they write the bad code
>
> That won't work - everyone will either disable the messages or will
> train themselves to ignore them.

the status quo is obviously not working.  i spent quite a bit of time
in the past to get the warnings down to 0 for my builds and all ive
seen since then is the # creep back up.  if people arent being made
aware of the issue, they obviously arent going to do anything about
it.  some people might condition themselves to ignore it, but that
applies to any sort of warning message.
-mike
