From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Jul 2017 09:29:24 +0200
Subject: [PATCH 2/6] ARM: shmobile_defconfig: Cleanup from non-existing
 options
In-Reply-To: <1500270596-22384-2-git-send-email-krzk@kernel.org>
References: <1500270596-22384-1-git-send-email-krzk@kernel.org>
 <1500270596-22384-2-git-send-email-krzk@kernel.org>
Message-ID: <CAMuHMdXWjw_k+-Fsv6gv8jH4hKvyZ_ygfVJqJ8QB4B8=LEfiGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Mon, Jul 17, 2017 at 7:49 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove options which do not exist anymore:
>  - DRM_RCAR_HDMI was merged to generic DRM bridge and is obsolete since
>    commit 5c602531feb3 ("drm: rcar-du: Replace manual bridge
>    implementation with DRM bridge");
>
>  - SND_SOC_RSRC_CARD was replaced by SND_SIMPLE_SCU_CARD in commit
>    d12c6216c4a5 ("ASoC: rsrc-card: rename rsrc-card to simple-scu-card
>    phase3");
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

These have already be fixed in the defconfig-for-v4.14 branch Simon Horman's
tree (git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git).

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git/log/?h=defconfig-for-v4.14

They're not yet in -next as v4.13-rc1 wasn't released at that time, and
Simon is now on holidays.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
