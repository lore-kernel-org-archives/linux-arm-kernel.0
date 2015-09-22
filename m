From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 22 Sep 2015 17:09:52 +0200
Subject: [PATCH v2 1/3] ARM: mvebu: add DT support for Seagate NAS 2 and
 4-Bay
In-Reply-To: <1442008373-19184-2-git-send-email-simon.guinot@sequanux.org>
References: <1442008373-19184-1-git-send-email-simon.guinot@sequanux.org>
 <1442008373-19184-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150922150952.GB16194@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 11:52:51PM +0200, Simon Guinot wrote:
> From: Vincent Donnefort <vdonnefort@gmail.com>
> 
> This patch adds DT support for the Seagate NAS 2 and 4-Bay.
> 
> Here are some informations allowing to identify these devices:
> 
> Product name                 | Seagate NAS 2-Bay | Seagate NAS 4-Bay
> Code name (board/PCB)        | Dart 2-Bay        | Dart 4-Bay
> Model name (case sticker)    | SRPD20            | SRPD40
> Material desc (product spec) | STCTxxxxxxx       | STCUxxxxxxx

Hi Simon

Thanks for adding this information.

> +	gpio-fan {
> +		compatible = "gpio-fan";
> +		gpios = <&gpio2 0 0
> +			 &gpio2 1 0>;
> +	};

Minor nit-pick

GPIO_ACTIVE_HIGH could be used here. Other than that:

Acked-by: Andrew Lunn <andrew@lunn.ch>

for the whole series.

	  Andrew
