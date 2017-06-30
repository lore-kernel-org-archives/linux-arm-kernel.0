From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Jun 2017 11:52:59 +0200
Subject: [PATCH v4 6/6] ARM: sun4i: Convert to CCU
In-Reply-To: <f4b2bbc20ca8afa9cc918ba8f781bd69ec3c6d00.1498422562.git-series.plaes@plaes.org>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
 <f4b2bbc20ca8afa9cc918ba8f781bd69ec3c6d00.1498422562.git-series.plaes@plaes.org>
Message-ID: <20170630095259.publzn56jy3ru5qb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 25, 2017 at 11:45:47PM +0300, Priit Laes wrote:
>  		osc24M: clk at 01c20050 {
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-osc-clk";
> @@ -187,487 +176,12 @@
>  			clock-output-names = "osc24M";
>  		};

This should be a fixed clock now.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170630/eb191f0a/attachment.sig>
