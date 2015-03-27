From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 27 Mar 2015 14:51:34 +0000
Subject: [PATCH v3 0/*] serial/amba-pl011: Activate TX IRQ passively
In-Reply-To: <20150326213014.GA21687@kroah.com>
References: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
 <20150326213014.GA21687@kroah.com>
Message-ID: <20150327145118.GA1711@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 10:30:14PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 25, 2015 at 06:22:26PM +0000, Dave Martin wrote:

[...]

> > Take your pick.
> 
> I have no idea what you want me to do here, sorry.
> 
> I need to apply patches to tty-next, I can't do anything against a
> "clean" 4.0-rc5 as your patches are already in tty-next.
> 
> And I can't tell the two series apart here...
> 
> Can you just resend what you want me to apply to tty-next and we can go
> from there?

Apologies, this was a misguided attempt on my part to be helpful.

I will post a v4 shortly, which changes nothing except for rebasing to
tty-next and clarifying the commit message on the second patch.

Note that I haven't seen any feedback from rmk since v1 (which, for
good reasons, he wasn't keen on).

I believe these patches resolve all issues reported so far by other
testers.

Cheers
---Dave
