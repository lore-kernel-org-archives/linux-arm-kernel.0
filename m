From: bobby.prani@gmail.com (Pranith Kumar)
Date: Wed, 25 Feb 2015 12:34:35 -0500
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <20150225171427.GE8656@n2100.arm.linux.org.uk>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
 <3465519.0ga9zC7F7b@wuerfel>
 <CAJhHMCCoFhi2a=qtO3EkX_Y-iy0C=STUt0ULtXMAyGEZJR_Vtw@mail.gmail.com>
 <16818946.F4B9s6bbtr@wuerfel> <20150225171427.GE8656@n2100.arm.linux.org.uk>
Message-ID: <CAJhHMCA74zi3qeAYTUKMsbVzxhggpzRzYKahj2WWApJ6g=hkLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 12:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Actually, I think we ought to get rid of __bad_xchg() so that cases
> like this cause a link error instead of a runtime error, just like we
> do in other cases as well.
>
> That's something that goes back ages (it used to be called something
> like invalidptr in 2.0 kernels...)

That sounds like a good idea. I will cook up a patch doing this.

Thanks!
-- 
Pranith
