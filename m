From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 12:44:26 -0600
Subject: [PATCH v2 04/11] Documentation: DT: binding: axp20x_usb_power:
 add axp223 compatible
In-Reply-To: <20161209110419.28981-5-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-5-quentin.schulz@free-electrons.com>
Message-ID: <20161212184426.s3pdaivchwxmiqr6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 12:04:12PM +0100, Quentin Schulz wrote:
> This adds the "x-powers,axp223-usb-power-supply" to the list of
> compatibles for AXP20X VBUS power supply driver.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> v2:
>  - adding small explanation on AXP223 variation compared to the AXP221,
> 
>  Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
