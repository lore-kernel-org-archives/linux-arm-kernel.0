From: robh@kernel.org (Rob Herring)
Date: Tue, 22 Aug 2017 19:38:03 -0500
Subject: [PATCH v2 2/2] ASoC: rockchip: separate pinctrl pins from each
 other
In-Reply-To: <1503303907-57630-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1503303907-57630-1-git-send-email-sugar.zhang@rock-chips.com>
 <1503303907-57630-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20170823003803.om33jtnfrsna5x4n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 04:25:07PM +0800, Sugar Zhang wrote:
> pdm sdi0~3 pins are optional, for example, if 4ch required,
> only sdi0~1 need to be enabled.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
