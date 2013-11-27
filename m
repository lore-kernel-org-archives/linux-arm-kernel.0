From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 27 Nov 2013 12:04:13 +0100
Subject: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <20131127082805.20015.82680.sendpatchset@w520>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127082805.20015.82680.sendpatchset@w520>
Message-ID: <20131127110413.GA2603@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eeprom: 24c128 at 50 {
> +			compatible = "at,24c128";

Minor nit: Should be a vendor name, not the name of the driver

> +			reg = <0x50>;
> +		};
> +	};
> +
>  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/0fa420d3/attachment.sig>
