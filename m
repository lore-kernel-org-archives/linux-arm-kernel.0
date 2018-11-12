From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 17:37:33 -0600
Subject: [PATCH 02/15] dt-bindings: net: broadcom-bluetooth: Add VBAT and
 VDDIO supplies
In-Reply-To: <20181107101308.7626-3-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-3-wens@csie.org>
Message-ID: <5bea0ebf.1c69fb81.545b4.234d@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Nov 2018 18:12:55 +0800, Chen-Yu Tsai wrote:
> The Broadcom Bluetooth chips have two power inputs, VBAT and VDDIO.
> The former provides overall power for the chip, while the latter powers
> the I/O pins and buffers.
> 
> This patch adds properties for the two so we can describe the power
> supply relationships.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
