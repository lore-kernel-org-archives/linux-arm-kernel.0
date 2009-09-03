From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 03 Sep 2009 12:04:06 +0200
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903015608.GB3917@prithivi.gnumonks.org> (Harald Welte's
	message of "Thu\, 3 Sep 2009 10\:56\:08 +0900")
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<200909021203.n82C3USg020804@chronolytics.com>
	<20090902191626.GP25153@trinity.fluff.org>
	<20090903015608.GB3917@prithivi.gnumonks.org>
Message-ID: <87pra8ny3t.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Harald" == Harald Welte <laforge@gnumonks.org> writes:

Hi,

 >> > I am also working on a "canonical" PWM backlight driver using the pwm_bl
 >> > lcd support and the 6410 pwm timer support in next-s3c.  It is mostly
 >> > working and should be ready to push soon.
 >> 
 >> I belive Peter Korsgaard's patch has already been merged to move the
 >> s3c24xx pwm code into the s3c.

 Harald> It's not yet in mainline, but if you believe it has been
 Harald> merged, then it should be a matter of time, right?

It's in s3c-next, so it should reach mainline in the upcoming merge
window.

 Harald> So yes, this needs a lot of thought and work, and I would
 Harald> rather want to see the less controversial 6410 bugfixes and
 Harald> drivers as well as the core support for the s5pc100 go in soon
 Harald> rather than spending months and months working on fancy jpeg
 Harald> accelerators...

Agreed.

-- 
Bye, Peter Korsgaard
