From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jun 2014 21:02:57 +0200
Subject: [Pull Request] Various ARM platform code fixes
In-Reply-To: <CAOesGMhsxKCVXJPX-JF96nvwstDp3crZKZzb3GVKX=dzZMMD0A@mail.gmail.com>
References: <CAK9yfHw=zecLHWHVZWvf3PzphYG3CDyTwMRXicUUFM4kkhT9Mw@mail.gmail.com>
 <CAOesGMhsxKCVXJPX-JF96nvwstDp3crZKZzb3GVKX=dzZMMD0A@mail.gmail.com>
Message-ID: <4750577.NRz8KZsHUG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 June 2014 09:42:48 Olof Johansson wrote:
> On Mon, Jun 2, 2014 at 2:23 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > Hi Arnd,
> >
> > As suggested by you I am sending a pull request for the below 8 patches.
> > These are based on for-next branch of arm-soc tree [1].
> >
> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> 
> Please, don't send random pull requests to us. Some of these patches
> are for platforms that have quite active maintainers and you're
> messing up everyone's workflow by randomly sending them to us.
> 
> I have no idea what you talked to Arnd about, and you give no
> reference to it in your pull request.

FYI, these are all trivial cleanups that no subarch maintainer has
picked up since they were posted, and I offered to take them
from a pull request
 
> Besides, the merge window is open, we're not taking anything new until
> after -rc1.

Agreed, I didn't expect the merge window to open already, and since there
is no urgency here, let's apply this into next/cleanups after the merge
window.

	Arnd
