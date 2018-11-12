From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 17:37:37 -0600
Subject: [PATCH 04/15] dt-bindings: net: broadcom-bluetooth: Add BCM4330
 compatible string
In-Reply-To: <20181107101308.7626-5-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-5-wens@csie.org>
Message-ID: <5bea0ec4.1c69fb81.45507.a045@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Nov 2018 18:12:57 +0800, Chen-Yu Tsai wrote:
> The BCM4330 is a 802.11 a/b/g/n WiFi + Bluetooth 4.0 chip from Broadcom.
> It is found in the Ampak AP6330 WiFi+BT module. The partiular one I have
> identifies as BCM4330B1 for Bluetooth and BCM4330/4 for WiFi.
> 
> It is unclear if the AP6330 module uses this revision of the BCM4330, or
> if there are multiple revisions. The module does not have revision
> markings. This patch elects to use just BCM4330 for the compatible
> string.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
