From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 Dec 2015 16:48:28 +0100
Subject: [GIT PULL 4/5] ARM: tegra: Devicetree changes for v4.5-rc1
In-Reply-To: <20151222195520.GI30172@localhost>
References: <1450356639-7758-1-git-send-email-thierry.reding@gmail.com>
 <1450356639-7758-4-git-send-email-thierry.reding@gmail.com>
 <20151222195520.GI30172@localhost>
Message-ID: <20151230154828.GC7085@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 11:55:20AM -0800, Olof Johansson wrote:
> On Thu, Dec 17, 2015 at 01:50:38PM +0100, Thierry Reding wrote:
> > Hi ARM SoC maintainers,
> > 
> > The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> > 
> >   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.5-dt
> > 
> > for you to fetch changes up to 336f79c7b6d7d04f7dad0361b9f4c8995107c062:
> > 
> >   arm64: tegra: Add NVIDIA Jetson TX1 Developer Kit support (2015-11-24 16:52:25 +0100)
> > 
> > Note that this pulls in the device tree bindings for the Tegra210 clock
> > and reset controller. A separate pull request is sent to the clock tree
> > maintainers including this commit. I've included this patch in the diff
> > stat below.
> > 
> > Thanks,
> > Thierry
> > 
> > ----------------------------------------------------------------
> > ARM: tegra: Devicetree changes for v4.5-rc1
> > 
> > This adds support for the Tegra132 Norrin and various Tegra210-based
> > reference designs. There is also an initial device tree for the Jetson
> > TX1 development kit.
> 
> Unfortunately can't merge this due to the feedback on your soc branch that is
> part of this.

In the past we've sent devicetree updates via a single branch for both
32-bit and 64-bit ARM. That's not the case for this cycle, but if we had
changes to both 32-bit and 64-bit ARM device trees, would you prefer
separate branches for those as well?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151230/b1b15554/attachment.sig>
