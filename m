From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 15:51:09 -0500
Subject: [PATCH v4 1/2] Documentation: bindings: add
 amlogic,meson-gxbb-scpi-sensors compatible
In-Reply-To: <20170530090507.16611-2-carlo@caione.org>
References: <20170530090507.16611-1-carlo@caione.org>
 <20170530090507.16611-2-carlo@caione.org>
Message-ID: <20170607205109.nej32uj5x4thbwdd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 11:05:06AM +0200, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Introduce a new Amlogic specific compatible to handle how Amlogic reports
> the sensor readings from SCPI using a different scale.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
