From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Jun 2013 17:01:19 +0900
Subject: [GIT PULL v2 00/27] Renesas ARM-based SoC updates for v3.11
In-Reply-To: <CAOesGMjDGkWO9YEqocv1ZFtDaaUPfoRMJNPEty6E3UDcGTeKew@mail.gmail.com>
References: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
 <20130611071925.GI6688@quad.lixom.net>
 <CAOesGMjDGkWO9YEqocv1ZFtDaaUPfoRMJNPEty6E3UDcGTeKew@mail.gmail.com>
Message-ID: <20130611080119.GC5300@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 12:23:40AM -0700, Olof Johansson wrote:
> On Tue, Jun 11, 2013 at 12:19 AM, Olof Johansson <olof@lixom.net> wrote:
> > Hi Simon,
> >
> > On Fri, Jun 07, 2013 at 04:51:30PM +0900, Simon Horman wrote:
> >> Hi Olof, Hi Arnd,
> >>
> >> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> >>
> >>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.11
> >
> > Thanks a lot for reshuffling the patches into the categories we use!
> >
> > For future cases, if you want to split off the cleanups you can do that as
> > a separate branch, and use that branch as a base for feature branches. Either
> > way works, sometimes it's nice to see cleanups separated out but it all depends
> > on volumes, etc.
> >
> >
> > Pulled into next/soc.
> 
> Actually, I just noticed that this caused a few conflicts with the
> pinmux-gpio branch you sent earlier. So I've moved said pinmux/gpio
> branch into next/soc instead of next/drivers where it was earlier.
> Please also check my conflict resolution once the branch has been
> pushed out.

Thanks. I have checked and your conflict resolution is the same as mine.

This is an issue that I'm not entirely clear on the best practice for.
Is it sufficient for me to note any conflicts in the pull-request,
or in future should I re-arrange things somehow?
