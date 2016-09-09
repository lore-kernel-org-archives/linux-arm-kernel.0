From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Sep 2016 16:54:07 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.8
In-Reply-To: <b03d92eb-ac69-506d-d05a-e28bca5ca284@codeaurora.org>
References: <20160907193335.GA4283@lukather>
 <b03d92eb-ac69-506d-d05a-e28bca5ca284@codeaurora.org>
Message-ID: <20160909145407.GF8881@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Sep 08, 2016 at 12:56:53PM -0700, Stephen Boyd wrote:
> On 09/07/2016 12:33 PM, Maxime Ripard wrote:
> > Hi Mike, Stephen,
> >
> > Please pull the following tag for the 4.8 release.
> >
> > Thanks!
> > Maxime
> >
> > The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> >
> >   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> >
> > are available in the git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.8
> >
> > for you to fetch changes up to 6654674cb7b5953ac04fc9d7f5f511676ae97e29:
> >
> >   clk: sunxi-ng: Fix wrong reset register offsets (2016-08-29 08:38:55 +0200)
> >
> > ----------------------------------------------------------------
> > Clock Fixes for the Allwinner SoCs, 4.8 Edition
> >
> > The usual bunch of fixes to the our clock drivers, mostly targetted to the
> > brand new sunxi-ng drivers.
> 
> Pulled, thanks. But,

Thanks!

> >
> > ----------------------------------------------------------------
> > Chen-Yu Tsai (2):
> >       clk: sunxi-ng: Fix inverted test condition in ccu_helper_wait_for_lock
> 
> we already had this one in clk-fixes. Git figured it out of course.

Hmmm, sorry, it was probably a mistake from when I got back from
vacation.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/6ea04eaf/attachment-0001.sig>
