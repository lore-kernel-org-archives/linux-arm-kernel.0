From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 19 Dec 2016 16:16:47 +0100
Subject: [PATCH net-next v4 2/4] dt-bindings: net: add EEE capability
 constants
In-Reply-To: <20161205143942.f3w6nmp3jvmrk5es@rob-hp-laptop>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
 <1480348229-25672-3-git-send-email-jbrunet@baylibre.com>
 <20161205143942.f3w6nmp3jvmrk5es@rob-hp-laptop>
Message-ID: <1482160607.5163.16.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

First, Thx for this information and sorry for this late reply
As you may have seen yourself, there was little bit of confusion while
discussing this patch series.

The point is the v3 was applied before your reply (patches 2 and 3 not
combined unfortunately).
Because of this confusion, the series needed a few fixes witch removes
the previously added bindings [0].
This time, I made sure to modify (remove) the bindings along with the
documentation.

[0]:?http://lkml.kernel.org/r/1482159938-13239-1-git-send-email-jbrunet
@baylibre.com

Cheers
Jerome

On Mon, 2016-12-05 at 08:39 -0600, Rob Herring wrote:
> On Mon, Nov 28, 2016 at 04:50:26PM +0100, Jerome Brunet wrote:
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> > Tested-by: Andreas F?rber <afaerber@suse.de>
> > Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> > ?include/dt-bindings/net/mdio.h | 19 +++++++++++++++++++
> > ?1 file changed, 19 insertions(+)
> > ?create mode 100644 include/dt-bindings/net/mdio.h
> 
> Seems changes are wanted on this, but patches 2 and 3 should be?
> combined. The header is part of the binding doc.
> 
> Rob
