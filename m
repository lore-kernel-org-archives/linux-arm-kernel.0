From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 1 Dec 2014 14:19:43 +0100
Subject: [GIT PULL 4/4] ARM: tegra: Core code changes for v3.19
In-Reply-To: <201411282249.58149.arnd@arndb.de>
References: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
 <1416570832-6220-4-git-send-email-thierry.reding@gmail.com>
 <201411282249.58149.arnd@arndb.de>
Message-ID: <20141201131942.GA11943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 10:49:57PM +0100, Arnd Bergmann wrote:
> On Friday 21 November 2014, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Hi ARM SoC maintainers,
> > 
> > The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> > 
> >   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-soc
> > 
> > for you to fetch changes up to e4a680099a6e97ecdbb81081cff9e4a489a4dc44:
> > 
> >   ARM: tegra: Re-add removed SoC id macro to tegra_resume() (2014-11-17 11:43:21 +0100)
> > 
> 
> Hmm, I guess this should have been part of 3.18, but I just sent out
> a pull request for fixes today, and it may have been the last time.
> 
> Pulled into next/fixes-non-critical now. I see that there is a stable
> tag on it, which means that it will find its way into 3.18.x, but it's
> really the wrong way to send a patch for the following merge window when
> there is a stable tag on it.

It didn't seem quite critical enough for it to get it into 3.18, but
perhaps it should still have gone that route. I'll try to be more
careful next time around.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/f567fedc/attachment.sig>
