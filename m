From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Dec 2016 09:51:33 +0100
Subject: [PATCH v2] ARM64: dts: marvell: Correct license text
In-Reply-To: <20161220224032.6866-1-alexandre.belloni@free-electrons.com>
 (Alexandre Belloni's message of "Tue, 20 Dec 2016 23:40:32 +0100")
References: <20161220224032.6866-1-alexandre.belloni@free-electrons.com>
Message-ID: <8737hhk6lm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,
 
 On mar., d?c. 20 2016, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> The license text has been mangled at some point then copy pasted across
> multiple files. Restore it to what it should be.
> Note that this is not intended as a license change.

I think you should rebase your patch on the current master branch of the
Linus tree, as since v4.9-rc1 a new dts was added for the EspressoBin
board which have the same issue.

Thanks,

Gregory

>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Changes in v2:
>  - squashed all the patches
>  - fix commit message
>
>  arch/arm64/boot/dts/marvell/armada-371x.dtsi   | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi   | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 10 +++++-----
>  4 files changed, 20 insertions(+), 20 deletions(-)
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
> index 1372e9a6aaa4..2e707875039a 100644
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
> index e9bd58793464..3c6f5d9d15c4 100644
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
