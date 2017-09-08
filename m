From: joel@jms.id.au (Joel Stanley)
Date: Fri, 8 Sep 2017 13:11:06 +0930
Subject: [patch v7 3/4] Documentation: jtag: Add bindings for Aspeed SoC
 24xx and 25xx families JTAG master driver
In-Reply-To: <1504281966-6199-4-git-send-email-oleksandrs@mellanox.com>
References: <1504281966-6199-1-git-send-email-oleksandrs@mellanox.com>
 <1504281966-6199-4-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CACPK8XeUtBXCZATNtK4K-kue3wmH34X3s6hNh0_1p2z7eNSoiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 2, 2017 at 1:36 AM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
> diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
> new file mode 100644
> index 0000000..f4ded49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
> @@ -0,0 +1,18 @@
> +Aspeed JTAG driver for ast2400 and ast2500 SoC
> +
> +Required properties:
> +- compatible:          Should be one of
> +      - "aspeed,aspeed2400-jtag"
> +      - "aspeed,aspeed2500-jtag"

Please use aspeed,ast2500-jtag and aspeed,ast2400-jtag.

Cheers,

Joel
