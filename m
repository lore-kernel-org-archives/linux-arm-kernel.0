From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 18:53:06 +0000
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <20150319184139.GG8656@n2100.arm.linux.org.uk>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <CAL_Jsq+sPkZtreQ0sp8KXpkUVpFy=Yh9dr249u8uyoa8yksjmg@mail.gmail.com>
 <20150319184139.GG8656@n2100.arm.linux.org.uk>
Message-ID: <20150319185306.GB11683@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> And yes, you are right - anything like this which we add immediately
> becames a user ABI which becomes *very* difficult to change later, so
> in order to accept anything like this, we have to be absolutely sure
> that this is something we really really really really want to do.  Let
> me put it another way: once this is accepted, it will probably be
> impossible to ever change it.

Agreed.

Having debugged issues with bad DTBs in the past without having this
information, I don't see it as being majorly helpful -- the DTB is
relatively simple and can be decompiled.

You don't gain much from being able to read which file it was built from
on a random server you don't have access to, and if you do have access
to the source it's relatively easy to discover the file it was built
from.

So unless there's a really compelling case for this, I don't see the
point in having it.

Mark.
