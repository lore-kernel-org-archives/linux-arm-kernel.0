From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 20 Mar 2012 22:23:53 -0400 (EDT)
Subject: [PATCH v8 0/8] Consolidate cpuidle functionality
In-Reply-To: <CAP245DXwhCMOJaspW8SY7jtqsA3d5SK4Ctr+JvS+cw4yHfL-mw@mail.gmail.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <201203202158.08042.arnd.bergmann@linaro.org> <873992zy5u.fsf@ti.com>
 <CAP245DXwhCMOJaspW8SY7jtqsA3d5SK4Ctr+JvS+cw4yHfL-mw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1203202146131.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Mar 2012, Amit Kucheria wrote:

> On Wed, Mar 21, 2012 at 12:48 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Maybe it's time that drivers/cpuidle gets a maintainer. ?With lots of
> > discussions of scheduler changes that affect load estimation, I suspect
> > we're all going to have a bit of CPUidle work to do in the
> > not-so-distant future.
> >
> 
> I don't mean to be piling on to Len here, but Daniel Lezcano too has a
> bunch of clean ups that didn't get any maintainer review for over two
> months. He has now refreshed them for 3.3 and is getting ready to send
> them out again. We (Linaro) expect to be spending a lot of time on
> cpuidle in the future and would be glad to help review, test and
> collect patches into a tree for Linus/Andrew to pull while we wait for
> Len to respond or another maintainer to emerge.

As I advised recently, it is usually a good idea for the person/group 
who is working the most on a subsystem to simply take the lead and 
become the new maintainer.  Waiting for another maintainer to emerge 
could be compared to cowardice.


Nicolas
