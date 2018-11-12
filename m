From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 17:37:35 -0600
Subject: [PATCH 03/15] dt-bindings: net: broadcom-bluetooth: Add
 BCM20702A1 compatible string
In-Reply-To: <20181107101308.7626-4-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-4-wens@csie.org>
Message-ID: <5bea0ec2.1c69fb81.4e0d5.a796@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Nov 2018 18:12:56 +0800, Chen-Yu Tsai wrote:
> The BCM20702A1 is a Bluetooth 4.0 chip from Broadcom. It is found in the
> Ampak AP6210 WiFi+BT module, identified from the read verbose config info
> command response. However the Bluetooth firmware provided by vendors uses
> the name BCM20710. This patch elects to use the chip ID returned by the
> chip for the compatible string.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
