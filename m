From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Jan 2018 15:14:25 -0200
Subject: [PATCH] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame
 Cap 7 initial support
In-Reply-To: <1514966447-30068-1-git-send-email-jagan@amarulasolutions.com>
References: <1514966447-30068-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAOMZO5Ac0OXdiSyvTpn+7xMP9hn1N4x+J+Ki2LrCB34XkNyh0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

On Wed, Jan 3, 2018 at 6:00 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-icore-ofcap7.dts
> @@ -0,0 +1,100 @@
> +/*
> + * Copyright (C) 2016 Amarula Solutions B.V.
> + * Copyright (C) 2016 Engicam S.r.l.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

Please consider using SPDX tag instead of this big license text:
// SPDX-License-Identifier: (GPL-2.0 OR MIT)

(Put it in the very first line of the dts file).


> +       panel {
> +               compatible = "ampire,am-800480aytzqw-00h";

I checked against linux-next and could not see this compatible string
documented.
