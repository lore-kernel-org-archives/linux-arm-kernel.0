From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Sep 2011 13:16:49 -0700
Subject: [PATCH 1/3] arm/tegra: Move EN_VDD_1V05_GPIO to board-harmony.h
In-Reply-To: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMisOtEQpcS-hHi-3brpYzJr-UiB6b71c+bwkesPDk9iuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 12:33 PM, Stephen Warren <swarren@nvidia.com> wrote:
> This centralizes all GPIO naming in one header.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>

> ---
> This patch series relies on various previous changes to the Tegra GPIO
> driver that were made in Russell's GPIO tree. I assume this series will
> go in through that tree.
>
> This first patch is cleanup which makes the second slightly cleaner (no
> need to edit board-harmony-pcie.c in patch 2). Usually, it would go in
> through the Tegra tree, but I think it makes sense to merge these 3
> patches all together in one place.

Works for me. Or I could stage it in a topic branch that would be
merged after Russell's GPIO tree.

Russell, Arnd, got any preferences for one or the other?


-Olof
