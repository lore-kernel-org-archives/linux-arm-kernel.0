From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Dec 2011 13:39:52 +0100
Subject: [PATCH 1/3] pinctrl: Implement PINMUX_MAP_SYS_HOG
In-Reply-To: <1323475145-26430-1-git-send-email-swarren@nvidia.com>
References: <1323475145-26430-1-git-send-email-swarren@nvidia.com>
Message-ID: <CACRpkdY=9ex2bSUC8ZscQ7t_xAK2TvCxMVajdQXoHZTZNRM9qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 10, 2011 at 12:59 AM, Stephen Warren <swarren@nvidia.com> wrote:

> This is the same as PINMUX_MAP_PRIMARY_SYS_HOG, except that it allows
> you to specify a particular control device.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Looks like a good idea, applied.

Linus Walleij
