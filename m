From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Apr 2014 17:33:51 +0100
Subject: [PATCH 1/5] ASoC: alc5623: Add device tree binding
In-Reply-To: <1397749994-24983-2-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-2-git-send-email-andrew@lunn.ch>
Message-ID: <20140418163351.GI12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 05:53:10PM +0200, Andrew Lunn wrote:

> + - compatible:	"realtek,alc5623"

You've not added an ID table to the driver for this.

> +  - add-ctrl:	Default register value for Reg-40h, Additional Control Register.
> +		If absent, the default is 0.

> +  - jack-det-ctrl:	Default register value for Reg-5Ah, Jack Detect
> +			Control Register. If absent, the default is 0.

I would expect the default for these to be to leave the hardware
defaults untouched - why is it different, what does setting to zero mean?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/055b6a53/attachment.sig>
