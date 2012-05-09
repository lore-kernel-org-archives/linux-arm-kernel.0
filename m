From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 9 May 2012 12:24:36 -0700
Subject: [PATCH v9 00/19] Introduce a led trigger for CPU activity and
 consolidate LED driver in ARM
In-Reply-To: <CAK5ve-KSyvZSHw7csQ5M88q0008NSrs1kwuyUH3hFqxD0f7BQQ@mail.gmail.com>
References: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
 <CAK5ve-J9uTJKC01XFTzU34MY4z_8yVRwTUVXP99Czu=oL-mqxQ@mail.gmail.com>
 <20120508121946.c20adb87.akpm@linux-foundation.org>
 <CAK5ve-KSyvZSHw7csQ5M88q0008NSrs1kwuyUH3hFqxD0f7BQQ@mail.gmail.com>
Message-ID: <20120509122436.1b612004.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 May 2012 00:16:14 +0800
Bryan Wu <bryan.wu@canonical.com> wrote:

> On Wed, May 9, 2012 at 3:19 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed, 9 May 2012 01:45:43 +0800
> > Bryan Wu <bryan.wu@canonical.com> wrote:
> >
> >> Any comments and suggestions about my v9 patchset.
> >
> > The drivers/leds/ changes look OK to me.
> 
> Thanks a lot, Andrew.
> Richard, what about merging this driver firstly in drivers/leds/?
> 

I'm the LEDs patchmonkey at present.  I can merge the drivers/leds
change if you like, but there doesn't seem much point in that unless
all the other patches get merged.

So my preferred approach would be for the patch series to get merged
via some ARM tree.



Failing that, I can merge them all myself.  Acks from ARM maintainers
and from maintainers of arm-specific drivers are very desirable, but I
wouldn't be surprised if few are forthcoming.

If nothing happens over the next week or so, please remind me (or resend
the patch series) and I'll suck them in.
