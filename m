From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jul 2017 17:37:02 +0200
Subject: [PATCH 1/6] ARM: multi_v7_defconfig: Cleanup from non-existing
 options
In-Reply-To: <20170717163716.GB2346@kozik-book>
References: <1500270596-22384-1-git-send-email-krzk@kernel.org>
 <CAMuHMdUnFCUKQdEcyFiKzVgkL5__ZLRMudCvkRxp6cBXgV6g=g@mail.gmail.com>
 <20170717163716.GB2346@kozik-book>
Message-ID: <20170727153702.GO16143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 06:37:16PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Jul 17, 2017 at 09:28:09AM +0200, Geert Uytterhoeven wrote:
> > Hi Krzysztof,
> > 
> > On Mon, Jul 17, 2017 at 7:49 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > Remove options which do not exist anymore:
> > 
> > <snip>
> > 
> > >  - DRM_RCAR_HDMI was merged to generic DRM bridge and is obsolete since
> > >    commit 5c602531feb3 ("drm: rcar-du: Replace manual bridge
> > >    implementation with DRM bridge");
> > >
> > >  - SND_SOC_RSRC_CARD was replaced by SND_SIMPLE_SCU_CARD in commit
> > >    d12c6216c4a5 ("ASoC: rsrc-card: rename rsrc-card to simple-scu-card
> > >    phase3");
> > 
> > These have already be fixed in the defconfig-for-v4.14 branch Simon Horman's
> > tree (git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git).
> > They're not yet in -next as v4.13-rc1 wasn't released at that time, and
> > Simon is noew on holidays.
> 
> I'll rebase then on top of his branch.

FYI, I have rebased that branch on top of v4.13-rc1 now that it has been
released (and I am back from holidays). I intend to push the updated branch
soon.
