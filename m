From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Nov 2016 14:03:45 +0100
Subject: [GIT PULL] Allwinner late DT changes for 4.10
In-Reply-To: <20161119002733.GA15902@localhost>
References: <20161115210034.mwqnsggmmbzoav77@lukather>
 <20161119002733.GA15902@localhost>
Message-ID: <20161121130345.mpdhouxqtrrv3x6u@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 04:27:33PM -0800, Olof Johansson wrote:
> On Tue, Nov 15, 2016 at 10:00:34PM +0100, Maxime Ripard wrote:
> > Hi Arnd, Olof,
> > 
> > Here is a pull request that should be merged after the pinctrl PR,
> > hence probably in your late PR.
> > 
> > This is just a mechanic conversion to the generic pinconf bindings and
> > removal of the useless pinmux properties we had.
> > 
> > This is based on the previous DT PR I just sent.
> > 
> > Thanks!
> > Maxime
> > 
> > The following changes since commit e39a30cf736144814b0bddb3fff28fbbc2a8be0f:
> > 
> >   ARM: sunxi: Add the missing clocks to the pinctrl nodes (2016-11-15 18:49:47 +0100)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-late-for-4.10
> > 
> > for you to fetch changes up to 1d20ba07ea57ae227a925302b42221df5b830f2b:
> > 
> >   ARM: sunxi: Convert pinctrl nodes to generic bindings (2016-11-15 21:56:30 +0100)
> 
> Nice cleanup!
> 
> Unfortuantely, see comment on previous pull request, so this would need
> to be rebased.
> 
> Also, this won't work since this branch does not contain the required
> pinctrl changes. If we merge this without basing it on those changes we lose
> bisectability.
> 
> It'd be easiest if you just held off on these until right after 4.10-rc1, and
> we could get them in before -rc2.

That works for me. I'll respin it as soon as rc1 is out.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/e2a43eee/attachment.sig>
