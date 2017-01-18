From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Jan 2017 16:22:38 -0600
Subject: [PATCH v3 1/3] Documentation: devicetree: move shared property
 used by rc into a common place
In-Reply-To: <1484292939-9454-2-git-send-email-sean.wang@mediatek.com>
References: <1484292939-9454-1-git-send-email-sean.wang@mediatek.com>
 <1484292939-9454-2-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170118222238.7iqt7joopu45dq46@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 03:35:37PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Most IR drivers uses the same label to identify the
> scancdoe/key table they used by multiple bindings and lack
> explanation well. So move the shared property into a common
> place and give better explanation.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/media/gpio-ir-receiver.txt |   3 +-
>  .../devicetree/bindings/media/hix5hd2-ir.txt       |   2 +-
>  Documentation/devicetree/bindings/media/rc.txt     | 116 +++++++++++++++++++++
>  .../devicetree/bindings/media/sunxi-ir.txt         |   2 +-
>  4 files changed, 120 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/rc.txt

Acked-by: Rob Herring <robh@kernel.org>

Thanks for doing this.

Rob
