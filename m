From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 21 Sep 2018 16:29:41 +0200
Subject: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix
 ethernet
In-Reply-To: <20180919141938.18791-1-rodrigo@tjader.xyz>
References: <20180919141938.18791-1-rodrigo@tjader.xyz>
Message-ID: <20180921142941.5ymp7ksphgboxrwz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 11:19:36AM -0300, Rodrigo Exterck?tter Tj?der wrote:
> Without "allwinner,tx-delay-ps = <600>;" on the DTP it can receive packets
> but not send.
> 
> Signed-off-by: Rodrigo Exterck?tter Tj?der <rodrigo@tjader.xyz>

Again, that commit log would be nice if it was a bit more
explicit. What is a DTP? How did you come up with that value? What is
the value used by Allwinner/Olimex, and why did you use another one if
you did?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/402f138c/attachment.sig>
