From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 8 Dec 2017 16:57:38 +0100
Subject: [RESEND PATCH V2] ARM: dts: introduce the sama5d2 ptc ek board
In-Reply-To: <20171207082453.10593-1-ludovic.desroches@microchip.com>
References: <20171206065844.27689-1-ludovic.desroches@microchip.com>
 <20171207082453.10593-1-ludovic.desroches@microchip.com>
Message-ID: <20171208155738.GA15660@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2017 at 09:24:53 +0100, Ludovic Desroches wrote:
> Add the official SAMA5D2 Peripheral Touch Controller Evaluation
> Kit board.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> Resend: Put SPDX-License-Identifier at the beginning of the file.
> 
> Changes:
> - v2:
>   - remove memory node
>   - use SPDX-License-Identifier
> 
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 401 ++++++++++++++++++++++++++++++
>  2 files changed, 402 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
