From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 5 Mar 2012 00:22:07 +0000
Subject: [PATCH 03/20] ARM: imx: merge audmux-v1 and audmux-v2
In-Reply-To: <1330788001-10158-4-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F54072E.6040407@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> +static unsigned char port_mapping[] = {
> +	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
> +};

May as well make this a 'const' array while you're at it.  And perhaps 
uint8_t is a better choice than "unsigned char".

-- 
Timur Tabi
Linux kernel developer at Freescale
