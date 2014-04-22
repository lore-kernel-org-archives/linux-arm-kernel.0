From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 16:54:15 +0200
Subject: [PATCH 4/4] pinctrl: tegra: print better error messages
In-Reply-To: <1397511222-28533-4-git-send-email-swarren@wwwdotorg.org>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
 <1397511222-28533-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdZi_T+MWwuKr5FJcYxBBBV6LBGujqXWaAyLzcTUJkH5Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 11:33 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> When an attempt is made to configure an unsupported option on a pin,
> print the DT property name of that option, so it's easier to debug
> what the problem is.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied with Laxman's ACK.

Yours,
Linus Walleij
