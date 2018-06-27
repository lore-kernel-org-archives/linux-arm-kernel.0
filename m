From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Jun 2018 16:41:09 +0530
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: Enable Bluetooth
In-Reply-To: <20180531202549.11255-3-david@lechnology.com>
References: <20180531202549.11255-1-david@lechnology.com>
 <20180531202549.11255-3-david@lechnology.com>
Message-ID: <5d45fabc-cc25-fbdf-859c-c29111b42eb2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 June 2018 01:55 AM, David Lechner wrote:
> This enables Bluetooth modules in davinic_all_defconfig needed for LEGO

davinci_all_defconfig

> MINDSTORMS EV3.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/configs/davinci_all_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)

> +CONFIG_SERIAL_DEV_BUS=y

Any reason to build this into the kernel?

Thanks,
Sekhar
