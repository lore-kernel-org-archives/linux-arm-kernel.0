From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 28 May 2018 18:36:47 +0200
Subject: [PATCH 10/12] ARM: dts: exynos5250: add DSI node
In-Reply-To: <1527501272-16365-1-git-send-email-m.purski@samsung.com>
References: <CGME20180528095444eucas1p222e4054b8fb8997258182e501f37a10b@eucas1p2.samsung.com>
 <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <1527501272-16365-1-git-send-email-m.purski@samsung.com>
Message-ID: <CAJKOXPdO1aTSvtHthyaMEjwURKn-FXUzhAr-N7ta0+DmUUr1vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 11:54 AM, Maciej Purski <m.purski@samsung.com> wrote:
> The patch adds common part of DSI node for Exynos5250 platforms.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)


This should be squashed with previous patch because it is logically
the same feature. The purpose of PHY is this DSI node so splitting it
is slightly too much.

Best regards,
Krzysztof
