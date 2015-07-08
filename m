From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 Jul 2015 14:55:18 -0600
Subject: [PATCH v1 3/3] ARM: tegra: Add gpio-ranges property
In-Reply-To: <1435754753-31307-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1435754753-31307-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435754753-31307-4-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <559D8E36.50209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2015 06:45 AM, Tomeu Vizoso wrote:
> Specify how the GPIOs map to the pins in Tegra SoCs, so the dependency is
> explicit.
>
> This currently will add a duplicated entry in the map from pins to gpios
> in the pinmux controller but it should be harmless and will be fixed in a
> later commit.

Isn't it in an earlier commit now (patch 2/3)? :-)

At a quick glance, I think this approach will be fine, so the series,
Acked-by: Stephen Warren <swarren@nvidia.com>
