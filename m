From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 19:17:17 -0600
Subject: [PATCH v4 1/4] Documentation: devicetree: Add document bindings
 for leds-mt6323
In-Reply-To: <1487962041-6548-2-git-send-email-sean.wang@mediatek.com>
References: <1487962041-6548-1-git-send-email-sean.wang@mediatek.com>
 <1487962041-6548-2-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170228011717.nbzjf76xdt5sq4a4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 02:47:18AM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds documentation for devicetree bindings
> for LED support on MT6323 PMIC

Also, please use "dt-bindings: leds: ..." for the subject prefix.

> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/leds/leds-mt6323.txt       | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
