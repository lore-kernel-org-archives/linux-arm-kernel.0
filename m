From: mars.cheng@mediatek.com (Mars Cheng)
Date: Wed, 4 Jul 2018 08:24:01 +0800
Subject: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for mediatek
 MT6765 Platform
In-Reply-To: <20180703221101.GA6829@rob-hp-laptop>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
 <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
 <20180703221101.GA6829@rob-hp-laptop>
Message-ID: <1530663841.28949.0.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On Tue, 2018-07-03 at 16:11 -0600, Rob Herring wrote:
> On Tue, Jun 26, 2018 at 10:04:05AM +0800, Mars Cheng wrote:
> > This adds dt-binding documentation for Mediatek MT6765. Only
> > include very basic items, gic, uart timer and cpu.
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
> >  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
> >  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
> 
> These can all go thru different trees, so should be split.
> 

Got it, will split them.

> >  3 files changed, 6 insertions(+)
