From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Feb 2018 17:18:55 +0100
Subject: [PATCH v2] arm64: dts: renesas: Add support for Salvator-XS with
 R-Car M3-N
In-Reply-To: <1519064455-12505-1-git-send-email-geert+renesas@glider.be>
References: <1519064455-12505-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180223161852.an5pmw6akj2na7tg@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 07:20:55PM +0100, Geert Uytterhoeven wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> Add initial support for the Renesas Salvator-XS (Salvator-X 2nd version)
> development board equipped with an R-Car M3-N SiP.
> 
> Most features are enabled through the shared salvator-xs.dtsi board
> description.  The memory configuration is specific to the M3-N SiP.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [geert: Switch to SPDX-License-Identifier, update patch description]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Fix patch prefix.

Thanks, applied.
