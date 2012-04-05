From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Apr 2012 11:19:00 -0700
Subject: [GIT PULL] omap fixes for v3.4-rc1
In-Reply-To: <CAOesGMg7DWDH4ix30fh23YZ1hg207S7oQ05njrfEBkaYPjKWDQ@mail.gmail.com>
References: <20120405004256.GB10780@atomide.com>
 <CAOesGMg7DWDH4ix30fh23YZ1hg207S7oQ05njrfEBkaYPjKWDQ@mail.gmail.com>
Message-ID: <20120405181900.GE3785@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [120405 10:51]:
> Hi,
> 
> On Wed, Apr 4, 2012 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi Arnd & Olof,
> >
> > Please pull omap fixes from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> >
> > Note that this also contains a set of fixes that are not regressions
> > or oopses to properly deal with the smsc911x regulator issue.
> >
> > Basically the regulators must be per board file as the regulators
> > can also come from drivers, such as twl4030. So it's best to dumb
> > down gpmc-smsc911x.c to not even care about the regulators.
> >
> > Regards,
> >
> > Tony
> >
> >
> > The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> > ?Linus Torvalds (1):
> > ? ? ? ?Linux 3.4-rc1
> >
> > are available in the git repository at:
> >
> > ?git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> 
> Thanks, pulled.

Thanks.
 
> Feel free to start sending these as signed tags with the above in the
> tag description, so it's carried forward in the git history without
> any work for us. :-)

OK will do.

Tony
