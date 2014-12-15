From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 15 Dec 2014 19:35:40 +0100
Subject: [PATCH 22/27] ARM: mvebu: armada-xp-mv78230: Relicense the
 device tree under GPLv2+/X11
In-Reply-To: <1418657915-22775-23-git-send-email-gregory.clement@free-electrons.com>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <1418657915-22775-23-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141215183540.GC30741@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 04:38:30PM +0100, Gregory CLEMENT wrote:
> The current GPL only licensing on the device tree makes it very
> impractical for other software components licensed under another
> license.
> 
> In order to make it easier for them to reuse our device trees,
> relicense our device trees under a GPL/X11 dual-license.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>

Acked-by: Andrew Lunn <andrew@lunn.ch>

> Cc: Arnaud Ebalard <arno@natisbad.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 40 +++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> index 281ccd24295c..6e6d0f04bf2b 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> @@ -5,9 +5,43 @@
>   *
>   * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>   *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
>   *
>   * Contains definitions specific to the Armada XP MV78230 SoC that are not
>   * common to all Armada XP SoCs.
> -- 
> 1.9.1
> 
