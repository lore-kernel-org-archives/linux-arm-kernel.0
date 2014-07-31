From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Jul 2014 09:42:45 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Clock Updates
 for v3.17
In-Reply-To: <CAOesGMi--0HO3Ae6mDfSrK=U+sFC201vb3UhfSPy_QisJN7FDg@mail.gmail.com>
References: <cover.1406766463.git.horms+renesas@verge.net.au>
 <CAOesGMi--0HO3Ae6mDfSrK=U+sFC201vb3UhfSPy_QisJN7FDg@mail.gmail.com>
Message-ID: <20140731004244.GA31873@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 05:35:51PM -0700, Olof Johansson wrote:
> On Wed, Jul 30, 2014 at 5:33 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> >
> > Please consider these fourth round of Renesas ARM based SoC clock
> > updates for v3.17.
> >
> > I am sending this even though v3.16-rc6 has long since been released
> > as this pull-request only includes a single one line fix for a problem
> > introduced in patches you have already queued up for v3.16.
> >
> > At it turns out the problem should not manifest at run time
> > as it is an error in an clock that is not used without DT modifications.
> > As such I am happy for you to ask me to defer this to v3.18 if you like.
> >
> > This pull request is based on the previous round of
> > such requests, tagged as renesas-clock3-for-v3.17,
> > which you have already merged.
> 
> It is less work to just apply a patch when there's a single one like
> this. Please just send it and ask us to apply it on top of the
> previous branch.

Thanks, I wasn't aware of that.

The patch was sent as a reply to this email, though you were not CCed
on the patch email. I will repost it with you CCed.
