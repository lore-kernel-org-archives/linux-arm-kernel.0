From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Oct 2017 15:50:00 -0500
Subject: [PATCH] firmware: meson-sm: use generic compatible
In-Reply-To: <20171012134743.10625-1-jbrunet@baylibre.com>
References: <20171012134743.10625-1-jbrunet@baylibre.com>
Message-ID: <20171017204959.kfbhn2yxhv2sb5qg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 03:47:43PM +0200, Jerome Brunet wrote:
> The meson secure monitor seems to be compatible with more SoCs than
> initially thought. Let's use the most generic compatible he have in
> DT instead of the gxbb specific one
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/firmware/meson/meson_sm.txt | 4 ++--
>  drivers/firmware/meson/meson_sm.c                             | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Seems like a pointless, not backwards compatible change to me. In the 
end, it's just a string to match on. Who cares what the string is.

Rob
