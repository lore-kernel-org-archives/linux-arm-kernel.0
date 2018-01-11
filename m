From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 16:09:53 -0600
Subject: [PATCH v2 07/16] dt-bindings: iio: adc: axp20x_adc: add AXP813
 variant
In-Reply-To: <64b538aadf075ba07e567d9a9db865b64c97fbfc.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <64b538aadf075ba07e567d9a9db865b64c97fbfc.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20180111220953.fk34fwpkahyd2ndk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 10:33:38AM +0100, Quentin Schulz wrote:
> AXP813 is now supported so add documentation for this compatible.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt |  9 +++++++++-
>  1 file changed, 9 insertions(+)

You can just squash this into the patch #2.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
