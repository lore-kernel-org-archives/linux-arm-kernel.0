From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 Jan 2017 08:51:06 -0800
Subject: [PATCH 30/37] ARM: dts: vf*-colibri: Correct license text
In-Reply-To: <20161214235746.7108-31-alexandre.belloni@free-electrons.com>
References: <20161214235746.7108-1-alexandre.belloni@free-electrons.com>
 <20161214235746.7108-31-alexandre.belloni@free-electrons.com>
Message-ID: <5e8ccdaf8022be395ab5ad3fc705d5b2@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-12-14 15:57, Alexandre Belloni wrote:
> The license test has been mangled at some point then copy pasted across
> multiple files. Restore it to what it should be.
> Note that this is not intended as a license change.

Hm, I introduced the Licence change for the Vybrid device trees, and
confirm that this was an oversight on my side.

FWIW, the patches I  have been involved with (30/31/32/34/35/37):

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Cc: Cory Tusar <cory.tusar@pid1solutions.com>
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi   | 10 +++++-----
>  arch/arm/boot/dts/vf-colibri.dtsi           | 10 +++++-----
>  arch/arm/boot/dts/vf500-colibri-eval-v3.dts | 10 +++++-----
>  arch/arm/boot/dts/vf500-colibri.dtsi        | 10 +++++-----
>  arch/arm/boot/dts/vf610-colibri-eval-v3.dts | 10 +++++-----
>  arch/arm/boot/dts/vf610-colibri.dtsi        | 10 +++++-----
>  arch/arm/boot/dts/vf610m4-colibri.dts       | 10 +++++-----
>  7 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> index 1e0b823f7e8f..091b738041a0 100644
> --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> @@ -10,17 +10,17 @@
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
> @@ -29,11 +29,11 @@
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
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi
> b/arch/arm/boot/dts/vf-colibri.dtsi
> index b7417094dc11..31356fdcde97 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -10,17 +10,17 @@
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
> @@ -29,11 +29,11 @@
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
> diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> index b3aeab58f718..076998968fb5 100644
> --- a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> @@ -10,17 +10,17 @@
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
> @@ -29,11 +29,11 @@
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
> diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi
> b/arch/arm/boot/dts/vf500-colibri.dtsi
> index 1a8a0efa19a6..515c4d2f28b0 100644
> --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> @@ -10,17 +10,17 @@
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
> @@ -29,11 +29,11 @@
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
> diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> index dbca4f86fdbb..ef9b4d6209f6 100644
> --- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> @@ -10,17 +10,17 @@
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
> @@ -29,11 +29,11 @@
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
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi
> b/arch/arm/boot/dts/vf610-colibri.dtsi
> index 9ec9e337f5a8..395812c52933 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -10,17 +10,17 @@
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
> @@ -29,11 +29,11 @@
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
> diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts
> b/arch/arm/boot/dts/vf610m4-colibri.dts
> index 2931a80caccb..7198e8cceb0d 100644
> --- a/arch/arm/boot/dts/vf610m4-colibri.dts
> +++ b/arch/arm/boot/dts/vf610m4-colibri.dts
> @@ -13,17 +13,17 @@
>   *     published by the Free Software Foundation; either version 2 of the
>   *     License, or (at your option) any later version.
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
> @@ -32,11 +32,11 @@
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
