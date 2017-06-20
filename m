From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jun 2017 09:45:48 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.12
In-Reply-To: <20170614235042.GF20170@codeaurora.org>
References: <20170614192119.xktlt4o5puje2pdu@flea.home>
 <20170614235042.GF20170@codeaurora.org>
Message-ID: <20170620074548.gqs6bpu2fo2bm67v@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Jun 14, 2017 at 04:50:42PM -0700, Stephen Boyd wrote:
> On 06/14, Maxime Ripard wrote:
> > Hi Mike, Stephen,
> > 
> > Please pull the following patches for 4.12
> > 
> > Thanks!
> > Maxime
> > 
> > The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> > 
> >   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.12
> > 
> > for you to fetch changes up to d85da227c3ae43d9ca513d60f244213cb4e55485:
> > 
> >   clk: sunxi-ng: a64: Export PLL_PERIPH0 clock for the PRCM (2017-05-31 21:57:30 +0200)
> > 
> > ----------------------------------------------------------------
> > Allwinner clock fixes for 4.12
> > 
> > Some fixes that fix some bindings that went in 4.12, fix a few reset and
> > clock offsets and a build error fix
> > 
> 
> The last few don't have any Fixes: tag. Is that because they
> aren't fixes for anything in the tree? I pulled it, but I'm
> second guessing it all.

They probably should have, I'm not sure about it. They are amendments
to one DT binding that got merged into 4.12, and must be merged before
the 4.12 release in order to not get bitten by the ABI stability rules.

So yeah, it probably should have had a Fixes tag in the first place.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/903018cf/attachment.sig>
