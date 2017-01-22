From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sun, 22 Jan 2017 17:33:03 +0800
Subject: [PATCH 3/3] dts: hisi: add dts files for Hi3516CV300 demo board
In-Reply-To: <20161017120705.3726-4-wenpan@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-4-wenpan@hisilicon.com>
Message-ID: <48bb201b-a443-13de-72ed-66a2b4982734@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/17 20:07, Pan Wen wrote:
> Add dts files for Hi3516CV300 demo board.
> 
> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
> ---
>  arch/arm/boot/dts/Makefile             |   1 +

[...]

> diff --git a/arch/arm/boot/dts/hi3516cv300.dtsi b/arch/arm/boot/dts/hi3516cv300.dtsi
> new file mode 100644
> index 0000000..1da41ab
> --- /dev/null
> +++ b/arch/arm/boot/dts/hi3516cv300.dtsi
> @@ -0,0 +1,397 @@
> +/*
> + * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "skeleton.dtsi"

please drop this include due to commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi as deprecated")

Thanks
Kefeng
