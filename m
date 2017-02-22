From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 09:08:26 -0600
Subject: [PATCH 4/7] dt-bindings: rockchip,pinctrl: rename RK1108 to RV1108
In-Reply-To: <1486983983-32506-1-git-send-email-andy.yan@rock-chips.com>
References: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
 <1486983983-32506-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20170222150826.c3u3rh6wnseedy35@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 07:06:23PM +0800, Andy Yan wrote:
> Rockchip finally named the SOC as RV1108, so change it.
> Also move the compatible list to one compatible per line.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/pinctrl/rockchip,pinctrl.txt     | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
