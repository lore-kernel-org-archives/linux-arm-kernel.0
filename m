From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 23 Aug 2016 21:55:51 +0200
Subject: [PATCH 0/4] ARM: dts: exynos: Enable HDMI in Arndale Octa board
In-Reply-To: <1471943619-6102-1-git-send-email-woogyom.kim@gmail.com>
References: <1471943619-6102-1-git-send-email-woogyom.kim@gmail.com>
Message-ID: <CAJKOXPew=cTK6RkiT+OoPbUcU2SBHdOYTSPG-av3FiN2HYNV=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 11:13 AM, Milo Kim <woogyom.kim@gmail.com> wrote:
> This patch-set enables HDMI in Arndale Octa board and fixes HPD DT property.
> It also includes code refactoring on ddc and phy.
>
> Milo Kim (4):
>   ARM: dts: exynos: Enable HDMI for Arndale Octa board
>   ARM: dts: exynos: Use 'hpd-gpios' instead of 'hpd-gpio'
>   gpu: drm: exynos_hdmi: Use consolidated function on binding DDC DT
>     property
>   gpu: drm: exynos_hdmi: Use consolidated function on binding PHY DT
>     property

I saw DTS patches on linux-samsung-soc patchwork but still I would
appreciate if you send them to appropriate maintainers pointed by
get_maintainers.pl script. DTS stuff goes through samsung-soc tree.

Best regards,
Krzysztof
