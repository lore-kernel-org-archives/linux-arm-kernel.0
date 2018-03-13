From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 13 Mar 2018 11:36:03 +0100
Subject: [PATCH] drm/meson: Add support for DMT modes on HDMI
In-Reply-To: <1520935670-14187-1-git-send-email-narmstrong@baylibre.com>
References: <1520935670-14187-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1520937363.4264.47.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-03-13 at 11:07 +0100, Neil Armstrong wrote:
> This patch adds support for DMT display modes over HDMI.
> The modes timings configurations are from the Amlogic Vendor linux tree
> and tested over multiples monitors.
> Previously only a selected number of CEA modes were supported.
> 
> Only these following modes are supported with these changes:
> - 640x480 at 60Hz
> - 800x600 at 60Hz
> - 1024x768 at 60Hz
> - 1152x864 at 75Hz
> - 1280x1024 at 60Hz
> - 1600x1200 at 60Hz
> - 1920x1080 at 60Hz
> 
> The associated code to handle the clock rates is also added.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Looks good to me

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
