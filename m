From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 11:22:18 +0100
Subject: [PATCH] pinctrl: tegra: fix some mistakes in Tegra124
In-Reply-To: <1394660147-9927-1-git-send-email-swarren@wwwdotorg.org>
References: <1394660147-9927-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdYD1rec_CEnyRK0hLTbGFue_s6SB9KvmpOs3v_DKbNF7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 10:35 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> A couple of pairs of pin group names were swapped in the table. This
> caused the wrong register to be programmed. Luckily, this had little
> effect, if any, since the swapped pins were likely to be programmed
> identically.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Patch applied.

Yours,
Linus Walleij
