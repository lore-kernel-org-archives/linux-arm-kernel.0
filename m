From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Mar 2016 10:26:56 -0700
Subject: Regression in next caused by 95026658c46e i2c: do not use
 internal..
In-Reply-To: <20160314165206.GA16371@katana>
References: <20160314160944.GG9329@atomide.com> <20160314165206.GA16371@katana>
Message-ID: <20160314172656.GH9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wolfram Sang <wsa@the-dreams.de> [160314 09:52]:
> Hi,
> 
> > Having something like this happen just as the merge window opens is
> > not nice. You guys should already know..
> 
> I already applied the fix.

OK great thanks!

> > The patches in next should be sitting there for a few weeks before the
> > merge window so issues like this are found out early.
> 
> I understand this was a major hickup and I am sorry for this. I should
> have known better.

Thanks for understanding my suffering :) I've been chasing various
regressions constantly over past months..  So I've started to keep my
eye on Linux next hoping to prevent being stuck chasing regressions
forever..

> I am not taking 100% of the blame, though: The amount of submissions is
> rising faster than the amount of non-maintainer review being done (at
> least in the subsystems I work on). I took a wrong step in trying to
> handle the gap. I am really sorry about the fuzz, yet I can't deny there
> is also something inevitable in that to me. That being said, I'll of
> course try harder to not let this happen again.

Yeah the same applies to may subsystems for sure. Probably a good idea
to be extra careful about not causing regressions with core subsystem
changes.

Regards,

Tony
