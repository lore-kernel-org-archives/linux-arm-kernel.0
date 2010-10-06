From: bgat@billgatliff.com (Bill Gatliff)
Date: Wed, 6 Oct 2010 11:20:15 -0500
Subject: [PATCHv3 0/7] PWM core driver for pwm based led and backlight
	driver
In-Reply-To: <1286380758-14063-1-git-send-email-arun.murthy@stericsson.com>
References: <1286380758-14063-1-git-send-email-arun.murthy@stericsson.com>
Message-ID: <AANLkTi=5yrcBPqbtDYRsnXTvhmBaYFemNu04P5ZnzJVM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arun:

On Wed, Oct 6, 2010 at 10:59 AM, Arun Murthy <arun.murthy@stericsson.com> wrote:
> PWM core driver for pwm based led and backlight driver.

With all due respect, it looks like you have reinvented portions of my
RFC for a comprehensive PWM API that has been floating around on
linux-embedded for over a year--- with an update coming in the last
two weeks or so.  Why?

To make matters worse, when I posted my original code I was told to
move the whole discussion to linux-embedded, because as a
cross-platform API proposal that's where it belongs.  I encourage you
do likewise.

I have a terse email style, so I just want to be clear that I'm not
mad or anything.  Honest!  I'm just disappointed that you've invested
so much hard work in traveling down the same path I came over a year
ago.  Bummer for everyone.

Can we not combine our efforts?  I haven't reviewed all of your
patches yet, but you are clearly ahead of me in specific ARM platform
support.  On the other hand, I think my code is more refined in many
other areas.  I also have Blackfin, PowerPC, and Cirrus (ARM) support,
though some of the code is from contributors who are holding it until
I proffer my final code.


What do you think?  Just let me know privately by email, or over on
linux-embedded.


Thanks!


b.g.
-- 
Bill Gatliff
bgat at billgatliff.com
