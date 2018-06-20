From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 12:26:15 -0600
Subject: [PATCH v3 6/9] dt-bindings: tc358754: add DT bindings
In-Reply-To: <1529396370-18761-7-git-send-email-m.purski@samsung.com>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082001eucas1p1df565ba7d1eaa320c2703e7dc019792b@eucas1p1.samsung.com>
 <1529396370-18761-7-git-send-email-m.purski@samsung.com>
Message-ID: <20180620182615.GA15792@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 10:19:27AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
> Bindings describe power supplies, reset gpio and video interfaces.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/bridge/toshiba,tc358764.txt   | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt

Reviewed-by: Rob Herring <robh@kernel.org>
