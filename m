From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Nov 2018 14:25:28 -0800
Subject: [PATCH] Support RTC charging on PFUZE100
In-Reply-To: <20181030143718.10027-1-aford173@gmail.com>
References: <20181030143718.10027-1-aford173@gmail.com>
Message-ID: <20181114222528.GE2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 09:37:18AM -0500, Adam Ford wrote:
> 
> diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
> index 1e5dcac70045..74ab5d65106b 100755
> --- a/arch/arm/boot/dts/imx6-logicpd-som.dtsi
> +++ b/arch/arm/boot/dts/imx6-logicpd-som.dtsi

> diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
> index 659e516455be..bdef74077d1c 100644
> --- a/drivers/regulator/pfuze100-regulator.c
> +++ b/drivers/regulator/pfuze100-regulator.c

Please follow the patch submission process covered in
submitting-patchest.rst.  You've not included a Signed-off-by which is
essential for legal reasons as covered in there and this is a single
patch which mixes a DT change and a regulator driver change which should
be in separate patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/f0c8519c/attachment.sig>
