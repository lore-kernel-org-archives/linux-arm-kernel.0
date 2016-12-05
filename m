From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Dec 2016 08:39:42 -0600
Subject: [PATCH net-next v4 2/4] dt-bindings: net: add EEE capability
 constants
In-Reply-To: <1480348229-25672-3-git-send-email-jbrunet@baylibre.com>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
 <1480348229-25672-3-git-send-email-jbrunet@baylibre.com>
Message-ID: <20161205143942.f3w6nmp3jvmrk5es@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 04:50:26PM +0100, Jerome Brunet wrote:
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> Tested-by: Andreas F?rber <afaerber@suse.de>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/dt-bindings/net/mdio.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/net/mdio.h

Seems changes are wanted on this, but patches 2 and 3 should be 
combined. The header is part of the binding doc.

Rob
