From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sat, 4 Apr 2015 13:24:36 +0300
Subject: [PATCHv6] media: i2c/adp1653: Documentation for devicetree
 support for adp1653
In-Reply-To: <20150404074337.GA31064@amd>
References: <20150402143846.GA11687@amd> <20150402203417.GA6336@amd>
 <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
Message-ID: <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Sat, Apr 04, 2015 at 09:43:37AM +0200, Pavel Machek wrote:
> 
> Documentation for adp1653 binding.

s/binding/bindings/

> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> 
> Please apply.
> 
> Sorry, wrong version of patch was sent last time.
> 									Pavel
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> new file mode 100644
> index 0000000..4607ce3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> @@ -0,0 +1,37 @@
> +* Analog Devices ADP1653 flash LED driver
> +
> +Required Properties:
> +
> +  - compatible: Must contain be "adi,adp1653"

s/be //

> +
> +  - reg: I2C slave address
> +
> +  - enable-gpios: Reference to the GPIO that controls the power for the chip.

How about:

enable-gpios: Specifier of the GPIO connected to EN pin

I can make the changes if you're ok with that, otherwise please send v7. Then
I'll apply that to my tree.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
