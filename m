From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 13:12:44 +0200
Subject: [Pull Request] Various ARM platform code fixes
In-Reply-To: <CAK5sBcF_wAJu-bfduhvP3kHfRvUDr=rUx=gd1Oi=3C5dnrHL6Q@mail.gmail.com>
References: <CAK9yfHw=zecLHWHVZWvf3PzphYG3CDyTwMRXicUUFM4kkhT9Mw@mail.gmail.com>
 <4750577.NRz8KZsHUG@wuerfel>
 <CAK5sBcF_wAJu-bfduhvP3kHfRvUDr=rUx=gd1Oi=3C5dnrHL6Q@mail.gmail.com>
Message-ID: <11158643.kH5ypbGTk1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 15:14:07 Sachin Kamat wrote:
> On Tue, Jun 3, 2014 at 12:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 02 June 2014 09:42:48 Olof Johansson wrote:
> >> On Mon, Jun 2, 2014 at 2:23 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> >> > Hi Arnd,
> >> >
> >> > As suggested by you I am sending a pull request for the below 8 patches.
> >> > These are based on for-next branch of arm-soc tree [1].
> >> >
> >> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> >>
> >> Please, don't send random pull requests to us. Some of these patches
> >> are for platforms that have quite active maintainers and you're
> >> messing up everyone's workflow by randomly sending them to us.
> >>
> >> I have no idea what you talked to Arnd about, and you give no
> >> reference to it in your pull request.
> >
> > FYI, these are all trivial cleanups that no subarch maintainer has
> > picked up since they were posted, and I offered to take them
> > from a pull request
> >
> >> Besides, the merge window is open, we're not taking anything new until
> >> after -rc1.
> >
> > Agreed, I didn't expect the merge window to open already, and since there
> > is no urgency here, let's apply this into next/cleanups after the merge
> > window.
> 
> Arnd, I no longer have access to my Linaro git repo. Shall I re-send
> the individual
> patches?

Yes, please do, and send them with Cc to both linux-arm-kernel at lists.infradead.org
and arm at kernel.org.

	Arnd
