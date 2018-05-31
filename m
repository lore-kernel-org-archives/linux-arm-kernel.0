From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 31 May 2018 11:39:02 +0200
Subject: [PATCH] arm64: allwinner: a64-amarula-relic: Enable AP6330 WiFi
 support
In-Reply-To: <20180529172238.9718-1-jagan@amarulasolutions.com>
References: <20180529172238.9718-1-jagan@amarulasolutions.com>
Message-ID: <20180531093902.j5cavatvsbb3iqis@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 29, 2018 at 10:52:38PM +0530, Jagan Teki wrote:
> +&rtc {
> +	clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
> +	clocks = <&osc32k>;
> +	#clock-cells = <1>;
> +};

It should be in the DTSI

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180531/51f74d7b/attachment.sig>
