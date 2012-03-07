From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2012 18:32:25 +0000
Subject: [PATCH 08/14] ARM: kirkwood: use devicetree for rtc-mv
In-Reply-To: <146e96ef8a8649767b3beb49ff39a260e75f234a.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <146e96ef8a8649767b3beb49ff39a260e75f234a.1331090356.git.jason@lakedaemon.net>
Message-ID: <201203071832.25307.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012, Jason Cooper wrote:
> +
> +       rtc at f1010300 {
> +               compatible = "mrvl,kirkwood-rtc", "mrvl,orion-rtc";
> +               reg = <0xf1010300 0x1f>;
> +               interrupts = <53>;
> +       };
>  };

Same as with the uart, this length should be 0x20 instead of 0x1f.

	Arnd
