From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 6 May 2014 10:05:26 -0700
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency for
 M25P80)
In-Reply-To: <CAOesGMh09AQ3Y-cdXFov3-+RZHDYTVw=MWngRumHc0hnB-CGOg@mail.gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
 <535A8FC9.8040707@wwwdotorg.org>
 <20140429190603.GB9418@norris-Latitude-E6410>
 <20140430114548.GQ28159@titan.lakedaemon.net>
 <CAOesGMi0zK8H=Ok81ZLhssvG5gsbvanY4dct_PF95Exq6p3tfg@mail.gmail.com>
 <20140504174216.GV28159@titan.lakedaemon.net>
 <CAOesGMh09AQ3Y-cdXFov3-+RZHDYTVw=MWngRumHc0hnB-CGOg@mail.gmail.com>
Message-ID: <20140506170526.GA28907@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 04, 2014 at 11:53:22AM -0700, Olof Johansson wrote:
> On Sun, May 4, 2014 at 10:42 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Sat, May 03, 2014 at 03:51:11PM -0700, Olof Johansson wrote:
> >> Cases like these are easiest that we just take the patch directly in
> >> an early-merge branch (i.e. cleanup or fixes-non-critical, or a
> >> generic depends branch), and if there's conflicts as topics are merged
> >> in from subplatforms we can deal with it then.
> >
> > Are you referring to basing on -rc1, or the series being split up to
> > the individual sub-arch maintainers?
> >
> > *slightly* confused,
> 
> I'm referring to us taking the patch into something like our cleanup
> branch, and any branches that come in from you or other subplatforms
> will be merged on top, so we can resolve conflicts there and then.
> We'll merge in the cleanup branch into other next/* branches as needed
> to resolve the conflicts in our tree instead of percolating them all
> the way up.

In case you didn't notice, I already had split up the patch series a
little more for v2 (based on -rc1 still), and most of it seems to be
going through the sub-arch trees, I think. There is one patch targeted
directly at arm-soc (that's you, Olof?).

Let me know if v2 has any problems.

Thanks,
Brian
