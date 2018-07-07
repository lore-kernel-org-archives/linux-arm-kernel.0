From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 10:55:27 +0200
Subject: [PATCH v3 8/9] ARM: dts: exynos5250: add DSI node
In-Reply-To: <1529396370-18761-9-git-send-email-m.purski@samsung.com>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082003eucas1p1ee69166282872a3c031caf08cb550269@eucas1p1.samsung.com>
 <1529396370-18761-9-git-send-email-m.purski@samsung.com>
Message-ID: <20180707085527.vdnbqy5digndxc7i@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 10:19:29AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds common part of DSI node for Exynos5250 platforms
> and a required mipi-phy node.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>

I see that bindings got Rob's ack but kbuild complained about driver
changes so I guess you are going resend everything? I'll wait with
applying these for v4.

Best regards,
Krzysztof
