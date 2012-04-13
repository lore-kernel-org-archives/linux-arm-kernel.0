From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 15:32:43 +0100
Subject: [PATCH v2 1/2] mfd: da9052: add device-tree support for i2c driver
In-Reply-To: <1334324261-5476-1-git-send-email-paul.liu@linaro.org>
References: <1334324261-5476-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120413143243.GW3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 09:37:40PM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +		regulators {
> +			buck0 {
> +				regulator-name = "DA9052_BUCK_CORE";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2075000>;
> +			};

This is more of a nit but these names look like they aren't terribly
idiomatic and could just be omitted - normally the name is used to tie
the name to the supply on the schematic so the above might be "VCORE" or
something.  If no name is provided then whatever the driver provides
will be used.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/a4f67742/attachment.sig>
