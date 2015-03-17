From: dwalker@fifo99.com (dwalker at fifo99.com)
Date: Tue, 17 Mar 2015 16:18:55 +0000
Subject: [PATCH 00/12] Remove mach-msm and associated code
In-Reply-To: <55034C70.4000403@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <3936339.LqGDoxnsbi@wuerfel> <55034C70.4000403@codeaurora.org>
Message-ID: <20150317161855.GA14895@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 01:45:36PM -0700, Stephen Boyd wrote:
> On 03/13/15 12:55, Arnd Bergmann wrote:
> > On Friday 13 March 2015 11:09:33 Stephen Boyd wrote:
> >> The maintainers for mach-msm no longer have any plans to support
> >> or test the platforms supported by this architecture[1]. Most likely
> >> there aren't any active users of this code anyway, so let's
> >> delete it and the associated drivers/code. We should probably merge
> >> this as one big series through arm-soc. Although some patches
> >> should be fine to take through maintainers, some things like
> >> mmc and usb have header file dependencies for platform_data.
> >>
> >> [1] http://lkml.kernel.org/r/20150307031212.GA8434 at fifo99.com
> >>
> > As I wrote, I'd have a mild preference for doing the multiplatform
> > conversion first and then removing the support in the following merge
> > window, just in case someone wants that code back.
> >
> > If everyone wants to see that code die rather sooner than later,
> > that's fine with me as well.
> 
> I think everyone wants to see the code die now. They can always pull the
> multi-platform patches from the list. I'll stash away my 7200 DT
> conversion in case someone cares but I really doubt anybody does.


I would say I want it to die , but it seems like you do .. It's fine with me
tho ..

Daniel
