From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 15 Sep 2013 12:54:22 +0200
Subject: [PATCH] ARM: tegra: add fuses as device randomness
In-Reply-To: <1379096828-27644-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096828-27644-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdZubWnsU2EAMrXxSRNpY7sH1rxkSixSuz_iSD5AfATTBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 8:27 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> Various fuses on Tegra include information that's unique to an individual
> chip, or a subset of chips. Call add_device_randomness() with this data
> to perturb the initial state of the random pool.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Nice! Acked-by FWIW.

Yours,
Linus Walleij
