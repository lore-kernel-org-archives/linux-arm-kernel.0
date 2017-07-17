From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Jul 2017 18:34:28 +0200
Subject: [PATCH 2/6] ARM: shmobile_defconfig: Cleanup from non-existing
 options
In-Reply-To: <CAMuHMdXWjw_k+-Fsv6gv8jH4hKvyZ_ygfVJqJ8QB4B8=LEfiGQ@mail.gmail.com>
References: <1500270596-22384-1-git-send-email-krzk@kernel.org>
 <1500270596-22384-2-git-send-email-krzk@kernel.org>
 <CAMuHMdXWjw_k+-Fsv6gv8jH4hKvyZ_ygfVJqJ8QB4B8=LEfiGQ@mail.gmail.com>
Message-ID: <20170717163428.GA2346@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 09:29:24AM +0200, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Mon, Jul 17, 2017 at 7:49 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Remove options which do not exist anymore:
> >  - DRM_RCAR_HDMI was merged to generic DRM bridge and is obsolete since
> >    commit 5c602531feb3 ("drm: rcar-du: Replace manual bridge
> >    implementation with DRM bridge");
> >
> >  - SND_SOC_RSRC_CARD was replaced by SND_SIMPLE_SCU_CARD in commit
> >    d12c6216c4a5 ("ASoC: rsrc-card: rename rsrc-card to simple-scu-card
> >    phase3");
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> These have already be fixed in the defconfig-for-v4.14 branch Simon Horman's
> tree (git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git).
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git/log/?h=defconfig-for-v4.14
> 
> They're not yet in -next as v4.13-rc1 wasn't released at that time, and
> Simon is now on holidays.

Ahhh, thanks for noticing this!

Best regards,
Krzysztof
