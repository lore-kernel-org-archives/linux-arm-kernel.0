From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Jan 2017 16:25:05 +0100
Subject: [PATCH v3] ARM64: dts: marvell: Correct license text
In-Reply-To: <20161227213650.16329-1-alexandre.belloni@free-electrons.com>
 (Alexandre Belloni's message of "Tue, 27 Dec 2016 22:36:50 +0100")
References: <20161227213650.16329-1-alexandre.belloni@free-electrons.com>
Message-ID: <87vatwf9ny.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,
 
 On mar., d?c. 27 2016, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> The license text has been mangled at some point then copy pasted across
> multiple files. Restore it to what it should be.
> Note that this is not intended as a license change.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
> Changes in v3:
>  - Rebased on v4.10-rc1 to fix espressobin
>
>  arch/arm64/boot/dts/marvell/armada-371x.dtsi            | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts          | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi            | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 10 +++++-----
>  5 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-371x.dtsi b/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> index c9e5325b8ac3..11226f7b9ed9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> @@ -16,17 +16,17 @@
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
> @@ -35,11 +35,11 @@
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
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 89de0a751093..f5f4c94f7070 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -15,17 +15,17 @@
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
> @@ -34,11 +34,11 @@
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
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 83178d909fc2..d26139ad8331 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -14,17 +14,17 @@
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
> @@ -33,11 +33,11 @@
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
> diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> index 5120296596c2..59d7557d3b1b 100644
> --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> @@ -16,17 +16,17 @@
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
> @@ -35,11 +35,11 @@
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
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index bab5c6ff5745..a02e9bcd190e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -15,17 +15,17 @@
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
> @@ -34,11 +34,11 @@
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
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
