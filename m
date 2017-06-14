From: robh@kernel.org (Rob Herring)
Date: Wed, 14 Jun 2017 10:30:08 -0500
Subject: [PATCH v4 2/4] Documentation: dt: iio: at91-sama5d2_adc: add hw
 trigger edge binding
In-Reply-To: <1496992039-17964-3-git-send-email-eugen.hristev@microchip.com>
References: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
 <1496992039-17964-3-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20170614153008.wgww2b5fweocqmmk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 10:07:17AM +0300, Eugen Hristev wrote:
> Add property for the edge type of the hardware trigger pin ADTRG
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>   Changes in v4:
>  - Modified bindings to be similar with interrupts
> 
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
