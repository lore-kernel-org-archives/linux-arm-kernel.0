From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 15 Dec 2016 11:38:28 +0100
Subject: [PATCH 23/39] ARM: dts: armada-xp-axpwifiap: Correct license text
In-Reply-To: <20161214223746.23066-24-alexandre.belloni@free-electrons.com>
References: <20161214223746.23066-1-alexandre.belloni@free-electrons.com>
 <20161214223746.23066-24-alexandre.belloni@free-electrons.com>
Message-ID: <37a43cbd-cc36-d3b7-af0b-2a5c1f7d1a08@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.12.2016 23:37, Alexandre Belloni wrote:
> The license test has been mangled at some point then copy pasted across
> multiple files. Restore it to what it should be.
> Note that this is not intended as a license change.
>
> Cc: Arnaud Ebalard <arno@natisbad.org>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Paul Bolle <pebolle@tiscali.nl>
> Cc: Rafa? Mi?ecki <zajec5@gmail.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Feel free to add my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

for Patches 23, 25, 27, 29, 30, 31, 32, 33, 35, 36, i.e. all I
have been in Cc.

Sebastian

> Cc: Stefan Roese <sr@denx.de>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> index ce152719bc28..6a25eb427822 100644
> --- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> +++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> @@ -20,17 +20,17 @@
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
> @@ -39,11 +39,11 @@
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
>
