From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Mon, 2 Jan 2017 09:23:27 +0100
Subject: [PATCH 28/37] ARM: dts: imx6ul-geam: Correct license text
In-Reply-To: <20161214235746.7108-29-alexandre.belloni@free-electrons.com>
References: <20161214235746.7108-1-alexandre.belloni@free-electrons.com>
 <20161214235746.7108-29-alexandre.belloni@free-electrons.com>
Message-ID: <20170102082326.GC4277@panicking>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 12:57:37AM +0100, Alexandre Belloni wrote:
> The license test has been mangled at some point then copy pasted across
> multiple files. Restore it to what it should be.
> Note that this is not intended as a license change.
> 
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Michael Trimarchi <michael@amarulasolutions.com>

> ---
>  arch/arm/boot/dts/imx6ul-geam-kit.dts | 10 +++++-----
>  arch/arm/boot/dts/imx6ul-geam.dtsi    | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-geam-kit.dts b/arch/arm/boot/dts/imx6ul-geam-kit.dts
> index 4c4af76143e3..142e60cab65f 100644
> --- a/arch/arm/boot/dts/imx6ul-geam-kit.dts
> +++ b/arch/arm/boot/dts/imx6ul-geam-kit.dts
> @@ -11,17 +11,17 @@
>   *     modify it under the terms of the GNU General Public License
>   *     version 2 as published by the Free Software Foundation.
>   *
> - *     This file is distributed in the hope that it will be useful
> + *     This file is distributed in the hope that it will be useful,
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>   *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   *     GNU General Public License for more details.
>   *
> - * Or, alternatively
> + * Or, alternatively,
>   *
>   *  b) Permission is hereby granted, free of charge, to any person
>   *     obtaining a copy of this software and associated documentation
>   *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use
> + *     restriction, including without limitation the rights to use,
>   *     copy, modify, merge, publish, distribute, sublicense, and/or
>   *     sell copies of the Software, and to permit persons to whom the
>   *     Software is furnished to do so, subject to the following
> @@ -30,11 +30,11 @@
>   *     The above copyright notice and this permission notice shall be
>   *     included in all copies or substantial portions of the Software.
>   *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>   *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>   *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>   *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>   *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   *     OTHER DEALINGS IN THE SOFTWARE.
> diff --git a/arch/arm/boot/dts/imx6ul-geam.dtsi b/arch/arm/boot/dts/imx6ul-geam.dtsi
> index 64eb9ed59b9c..940aef67313b 100644
> --- a/arch/arm/boot/dts/imx6ul-geam.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-geam.dtsi
> @@ -11,17 +11,17 @@
>   *     modify it under the terms of the GNU General Public License
>   *     version 2 as published by the Free Software Foundation.
>   *
> - *     This file is distributed in the hope that it will be useful
> + *     This file is distributed in the hope that it will be useful,
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>   *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   *     GNU General Public License for more details.
>   *
> - * Or, alternatively
> + * Or, alternatively,
>   *
>   *  b) Permission is hereby granted, free of charge, to any person
>   *     obtaining a copy of this software and associated documentation
>   *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use
> + *     restriction, including without limitation the rights to use,
>   *     copy, modify, merge, publish, distribute, sublicense, and/or
>   *     sell copies of the Software, and to permit persons to whom the
>   *     Software is furnished to do so, subject to the following
> @@ -30,11 +30,11 @@
>   *     The above copyright notice and this permission notice shall be
>   *     included in all copies or substantial portions of the Software.
>   *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>   *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>   *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>   *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>   *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   *     OTHER DEALINGS IN THE SOFTWARE.
> -- 
> 2.10.2
> 

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
