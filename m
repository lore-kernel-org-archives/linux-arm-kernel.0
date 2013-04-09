From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 10:45:49 +0900
Subject: GENERIC_GPIO considered deprecated
In-Reply-To: <20130409101035.c59edcf9fa6e40a064f7fe41@canb.auug.org.au>
References: <CAAVeFu+QUw1WmzwaJDfjyw75PrStd3p3PHs1MU5BC7_WXMB7kw@mail.gmail.com>
 <2c9501ce342b$1535d290$3fa177b0$%kim@samsung.com>
 <5162EC32.2030602@wwwdotorg.org> <201304082136.44905.arnd@arndb.de>
 <20130409093842.656ae3fff92d5368db5c0646@canb.auug.org.au>
 <CAAVeFuJCxYiOXRkjJZXpSFUaGoiAtWwBWBJmxXUyQMkmrSEsew@mail.gmail.com>
 <20130409101035.c59edcf9fa6e40a064f7fe41@canb.auug.org.au>
Message-ID: <2e6101ce34c3$f6449580$e2cdc080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell wrote:
> 
> Hi,
> 
> On Mon, 8 Apr 2013 17:07:54 -0700 Alexandre Courbot <gnurou@gmail.com>
> wrote:
> >
> > On Mon, Apr 8, 2013 at 4:38 PM, Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
> > >
> > > On Mon, 8 Apr 2013 21:36:44 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > >>
> > >> On Monday 08 April 2013, Stephen Warren wrote:
> > >> > >>
> > >> > >> Should do the trick, if we can make sure that your tree is
> merged
> > >> > >> prior to my patches.
> > >> > >
> > >> > > I'm not sure but I think, arm-soc tree should be merged into
> mainline before others...
> > >> > >
> > >> > >> Can you put it into your tree for 3.10?
> > >> > >>
> > >> > > I did, so it should be fine.
> > >> > >
> > >> >
> > >> > You may want to discuss how to handle this dependency with the arm-
> soc
> > >> > maintainers (CC'd).
> > >>
> > >> I'm fine with putting the same branch into arm-soc as well as the
> gpio tree
> > >> and anything else that might need it, that tends to be the least
> invasive
> > >> way.
> > >
> > > Just a reminder: that had better be the exact same branch and that
> branch
> > > had better never be rebased/rewritten ...
> >
> > Sorry, which branch are we talking about - is it the one I published
> > for -next initially? If so wouldn't it be simpler to withdraw it and
> > have Grant integrate the patches in his branch? Since no one depends
> > on them for now anyway...
> >
> > I remember rebasing it once some time ago to add Acked-bys, but it
> > hasn't changed since then.
> 
> I am talking about the branch that Arnd says should be merged into both
> the arm-soc and gpio trees.
> 
Well, AFAIK, the problem including "select GENERIC_GPIO" happened only in
samsung tree so arm-soc tree is enough. If any problems, please let me know.

Arnd, just note, the fix is included in my pull-request [09/10].

Thanks.

- Kukjin
