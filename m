From: hs@denx.de (Heiko Schocher)
Date: Thu, 15 Dec 2016 06:29:14 +0100
Subject: [PATCH 01/37] ARM: dts: imx6dl-aristainetos2: Correct license text
In-Reply-To: <20161214235746.7108-2-alexandre.belloni@free-electrons.com>
References: <20161214235746.7108-1-alexandre.belloni@free-electrons.com>
 <20161214235746.7108-2-alexandre.belloni@free-electrons.com>
Message-ID: <58522A2A.3030000@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexandre,

Am 15.12.2016 um 00:57 schrieb Alexandre Belloni:
> The license test has been mangled at some point then copy pasted across
> multiple files. Restore it to what it should be.
> Note that this is not intended as a license change.
>
> Cc: Dong Aisheng <aisheng.dong@freescale.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Rafa? Mi?ecki <zajec5@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/imx6dl-aristainetos2_4.dts | 10 +++++-----
>   arch/arm/boot/dts/imx6dl-aristainetos2_7.dts | 10 +++++-----
>   arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 10 +++++-----
>   3 files changed, 15 insertions(+), 15 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

Hmm.. BTW ... is this copy and paste not boring? Should we not
use "SPDX-License-Identifier" [1] like for example in U-Boot ?

bye,
Heiko
[1] https://spdx.org/licenses/

>
> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
> index bb92f309c191..0677625463d6 100644
> --- a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
> +++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
> @@ -12,17 +12,17 @@
>    *     modify it under the terms of the GNU General Public License
>    *     version 2 as published by the Free Software Foundation.
>    *
> - *     This file is distributed in the hope that it will be useful
> + *     This file is distributed in the hope that it will be useful,
>    *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>    *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>    *     GNU General Public License for more details.
>    *
> - * Or, alternatively
> + * Or, alternatively,
>    *
>    *  b) Permission is hereby granted, free of charge, to any person
>    *     obtaining a copy of this software and associated documentation
>    *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use
> + *     restriction, including without limitation the rights to use,
>    *     copy, modify, merge, publish, distribute, sublicense, and/or
>    *     sell copies of the Software, and to permit persons to whom the
>    *     Software is furnished to do so, subject to the following
> @@ -31,11 +31,11 @@
>    *     The above copyright notice and this permission notice shall be
>    *     included in all copies or substantial portions of the Software.
>    *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>    *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>    *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>    *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>    *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>    *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>    *     OTHER DEALINGS IN THE SOFTWARE.
> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
> index 3d5ad2cc7e22..805b1318b7f7 100644
> --- a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
> +++ b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
> @@ -12,17 +12,17 @@
>    *     modify it under the terms of the GNU General Public License
>    *     version 2 as published by the Free Software Foundation.
>    *
> - *     This file is distributed in the hope that it will be useful
> + *     This file is distributed in the hope that it will be useful,
>    *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>    *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>    *     GNU General Public License for more details.
>    *
> - * Or, alternatively
> + * Or, alternatively,
>    *
>    *  b) Permission is hereby granted, free of charge, to any person
>    *     obtaining a copy of this software and associated documentation
>    *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use
> + *     restriction, including without limitation the rights to use,
>    *     copy, modify, merge, publish, distribute, sublicense, and/or
>    *     sell copies of the Software, and to permit persons to whom the
>    *     Software is furnished to do so, subject to the following
> @@ -31,11 +31,11 @@
>    *     The above copyright notice and this permission notice shall be
>    *     included in all copies or substantial portions of the Software.
>    *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>    *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>    *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>    *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>    *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>    *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>    *     OTHER DEALINGS IN THE SOFTWARE.
> diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> index 7fff02c406f2..6450699859ce 100644
> --- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> @@ -12,17 +12,17 @@
>    *     modify it under the terms of the GNU General Public License
>    *     version 2 as published by the Free Software Foundation.
>    *
> - *     This file is distributed in the hope that it will be useful
> + *     This file is distributed in the hope that it will be useful,
>    *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>    *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>    *     GNU General Public License for more details.
>    *
> - * Or, alternatively
> + * Or, alternatively,
>    *
>    *  b) Permission is hereby granted, free of charge, to any person
>    *     obtaining a copy of this software and associated documentation
>    *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use
> + *     restriction, including without limitation the rights to use,
>    *     copy, modify, merge, publish, distribute, sublicense, and/or
>    *     sell copies of the Software, and to permit persons to whom the
>    *     Software is furnished to do so, subject to the following
> @@ -31,11 +31,11 @@
>    *     The above copyright notice and this permission notice shall be
>    *     included in all copies or substantial portions of the Software.
>    *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>    *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>    *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>    *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>    *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>    *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>    *     OTHER DEALINGS IN THE SOFTWARE.
>

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
