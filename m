From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 28 Feb 2018 14:19:51 +0100
Subject: [PATCH 2/3] ARM: dts: sun8i: a711: set regulator for each
 cluster of CPUs
In-Reply-To: <07883d44949420891c1ed2411ff15199d53075c0.1519823347.git-series.quentin.schulz@bootlin.com>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
 <07883d44949420891c1ed2411ff15199d53075c0.1519823347.git-series.quentin.schulz@bootlin.com>
Message-ID: <20180228141951.3a06bc11@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 28 Feb 2018 14:11:21 +0100, Quentin Schulz wrote:

> @@ -136,6 +144,7 @@
>   * An USB-2 hub is connected here, which also means we don't need to
>   * enable the OHCI controller.
>   */
> +
>  &ehci0 {
>  	status = "okay";
>  };

Spurious change.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
