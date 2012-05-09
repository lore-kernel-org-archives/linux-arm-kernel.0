From: rpurdie@rpsys.net (Richard Purdie)
Date: Thu, 10 May 2012 00:52:10 +0100
Subject: [PATCH v9 00/19] Introduce a led trigger for CPU activity and
 consolidate LED driver in ARM
In-Reply-To: <CAK5ve-Ko6EjZsJBW++ofL0eHxiR5W+wafb3T99Rm9a1L8pHLBQ@mail.gmail.com>
References: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
 <CAK5ve-KSyvZSHw7csQ5M88q0008NSrs1kwuyUH3hFqxD0f7BQQ@mail.gmail.com>
 <20120509122436.1b612004.akpm@linux-foundation.org>
 <201205092038.16722.arnd.bergmann@linaro.org>
 <CAK5ve-Ko6EjZsJBW++ofL0eHxiR5W+wafb3T99Rm9a1L8pHLBQ@mail.gmail.com>
Message-ID: <1336607530.2494.111.camel@ted>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-10 at 07:41 +0800, Bryan Wu wrote:
> On Thu, May 10, 2012 at 4:38 AM, Arnd Bergmann <arnd.bergmann@linaro.org> wrote:
> > On Wednesday 09 May 2012, Andrew Morton wrote:
> >> I'm the LEDs patchmonkey at present.  I can merge the drivers/leds
> >> change if you like, but there doesn't seem much point in that unless
> >> all the other patches get merged.
> >>
> >> So my preferred approach would be for the patch series to get merged
> >> via some ARM tree.
> >
> > I'm fine with taking it through arm-soc if that helps.
> 
> That would be great to merge from arm-soc tree, thanks a lot, Arnd and Andrew.
> 
> > In the long run,
> > it would be nice to have a proper maintainer for this again after Richard
> > more or less stepped down from that position. Given that Bryan has shown
> > that he's persistent enough to get this patch series to v9, how about
> > making him the primary maintainer for the entire subsystem? He should
> > know a lot about it already. Bryan?
> >
> 
> I do love to start to do more contribution and maintain the
> drivers/leds subsystem with Richard's help, if Richard is fine with
> this, I can send out patch to add a MAINTAINER entry.

I'm ok with that, I'm also happy to stay involved at a distance. I do
read emails and try and help where I can :). I'm just not doing day to
day rebuilds of cutting edge kernels so the patch work isn't something
I've been able to find time for and the Yocto Project is where my main
focus appears best placed at the moment.

Cheers,

Richard
