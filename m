From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 07 Oct 2016 08:12:13 -0700
Subject: [PATCH v2] ARM64: dts: meson-gxbb: Add rmii pinctrl node and
 rename rgmii node
In-Reply-To: <1475852355-24096-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 7 Oct 2016 16:59:15 +0200")
References: <1475852355-24096-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hy420dwhe.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> For boards only supporting 10/100 ethernet over a RMII PHY link, add
> a separate pinctrl node. By the way, rename the existing node to rgmii
> specific naming in all boards dts.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.10/dt64,

Kevin
