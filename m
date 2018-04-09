From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Apr 2018 13:47:43 -0500
Subject: [PATCH v2 08/10] dt-bindings: iio: adc: at91-sama5d2_adc: add
 channel specific consumer info
In-Reply-To: <1522153963-1121-9-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
 <1522153963-1121-9-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180409184743.zu7ihom6tvi7aino@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 03:32:41PM +0300, Eugen Hristev wrote:
> Added defines for channel consumer device-tree binding
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt     |  9 +++++++++
>  include/dt-bindings/iio/adc/at91-sama5d2_adc.h           | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h

Reviewed-by: Rob Herring <robh@kernel.org>
