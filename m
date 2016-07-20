From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 20 Jul 2016 10:52:46 +0200
Subject: [PATCH] ARM: shmobile: r8a7794: tidyup SDHI register size on DTSI
In-Reply-To: <1469002759-2860-1-git-send-email-horms+renesas@verge.net.au>
References: <1469002759-2860-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160720085246.GA1673@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -		reg = <0 0xee100000 0 0x200>;
> +		reg = <0 0xee100000 0 0x384>;

All other r8a779x.dtsi have 0x328 there.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160720/75ea51e0/attachment.sig>
