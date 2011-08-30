From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 17:13:04 -0700
Subject: [PATCH 3/3] TI814X: Create board support and enable build for
	TI8148 EVM
In-Reply-To: <1312479903-22909-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Thu, 4 Aug 2011 23:15:03 +0530")
References: <1312479903-22909-1-git-send-email-hemantp@ti.com>
Message-ID: <878vqbpxin.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch adds minimal support and build configuration for TI8148 EVM. Also
> adds support for low level debugging on UART1 console on the EVM.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

[...]

> +static void __init ti8148_init_early(void)
> +{
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(NULL, NULL);

Note that this function no longer exists in mainline.

Kevin
