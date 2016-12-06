From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Dec 2016 11:49:53 -0800
Subject: [RFC PATCH 23/23] arm: use kconfig fragments for
 tegra_defconfig/multi_v7_defconfig
In-Reply-To: <1481027938-31831-24-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
 <1481027938-31831-24-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CAOesGMgUnz3WMq_cfabMkFfkp-hvja2TegXubKxFXuMmVNHphQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 6, 2016 at 4:38 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Replace [tegra,multi_v7]_defconfig-s with
> a Makefile target using merge_config.
>
> The patch was verified with doing:
>
>     $ make [tegra,multi_v7]_defconfig
>     $ make savedefconfig
>
> and comparing resulting defconfig files (before/after the patch).
>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-tegra at vger.kernel.org
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I'll just reply to this one patch in addition to the cover letter (you
sent the patches to more people than the cover letter, which means
that most people who see these patches don't have full context).

NACK. See cover letter reply for motivation thereof.


-Olof
