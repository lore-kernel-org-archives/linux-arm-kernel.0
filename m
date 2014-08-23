From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 23 Aug 2014 10:32:23 -0300
Subject: [PATCH 6/6] ARM: dts: hummingboard: gpio-ir on gpio 3,5
In-Reply-To: <E1XL7MR-0002yX-6N@rmk-PC.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7MR-0002yX-6N@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOMZO5C=xyYLLBX1PDsJQ9NwzXZxCWTvPMTUWzYcoohOOvA_qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 6:11 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> -                               MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
> +                               MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x80000000

It would be better to replace the '0x80000000' with the real iomux
value (like 0x1b0b0 for example), so that we do not need to rely on
the bootloader doing the correct configuration for us.
