From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Aug 2017 21:42:09 -0500
Subject: [PATCH v4 2/9] ASoC: rockchip: Remove obsolete dmic-delay
In-Reply-To: <20170818031147.16810-3-jeffy.chen@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
 <20170818031147.16810-3-jeffy.chen@rock-chips.com>
Message-ID: <20170822024209.ej6y7pv77ztupvrq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 11:11:40AM +0800, Jeffy Chen wrote:
> This property is no longer used.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt           |  7 -------
>  sound/soc/rockchip/rk3399_gru_sound.c                      | 14 --------------
>  2 files changed, 21 deletions(-)

Well, obviously not used since they don't even match.

Acked-by: Rob Herring <robh@kernel.org>
