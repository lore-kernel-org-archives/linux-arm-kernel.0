From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Sun, 28 Aug 2016 10:09:36 +0200
Subject: [PATCH v2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <20160828005521.58221-1-icenowy@aosc.xyz>
References: <20160828005521.58221-1-icenowy@aosc.xyz>
Message-ID: <20160828080334.e7kul4n75i3hqk5t@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2016 at 08:55:21AM +0800, Icenowy Zheng wrote:
> +			uart1_pins_cts_rts_a: uart1_cts_rts at 0 {
> +				allwinner,pins = "PG8", "PG9";
> +				allwinner,function = "uart1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};

Node names should not contain underscores. Use hyphens instead.
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

-- 
Rask Ingemann Lambertsen
