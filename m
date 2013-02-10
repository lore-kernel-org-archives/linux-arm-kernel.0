From: tony@atomide.com (Tony Lindgren)
Date: Sat, 9 Feb 2013 18:42:28 -0800
Subject: [GIT PULL] omap twl platform init changes for v3.9 merge window
In-Reply-To: <20130210005824.GJ16278@quad.lixom.net>
References: <20130206172500.GA25185@atomide.com>
 <20130210005824.GJ16278@quad.lixom.net>
Message-ID: <20130210024228.GA4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130209 17:01]:
> On Wed, Feb 06, 2013 at 09:25:00AM -0800, Tony Lindgren wrote:
> > The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> > 
> >   Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/twl-signed-v2
> 
> <standard complaint>
> It would be nice to see TI enabling device-tree on these platforms/drivers
> instead of adding to legacy board files.
> </standard complaint>

I believe it already has at least for audio, but we cannot yet drop
the legacy support. Currently am33xx is DT only, omap4 is pretty close
to be flipped over to be DT only.
 
> Pulled into next/boards.

Thanks,

Tony
