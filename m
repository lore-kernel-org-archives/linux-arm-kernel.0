From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jul 2017 17:09:00 +0200
Subject: [PATCH 0/4] soc: renesas: Add R-Car D3 support
In-Reply-To: <1500554094-22198-1-git-send-email-geert+renesas@glider.be>
References: <1500554094-22198-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170727150859.GE16143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:34:50PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds R-Car D3 support to the Renesas-specific SoC
> drivers:
>   - SoC identification,
>   - System controller,
>   - Reset controller.
> 
> Thanks!
> 
> Geert Uytterhoeven (4):
>   soc: renesas: Identify R-Car D3
>   soc: renesas: Add r8a77995 SYSC PM Domain Binding Definitions
>   soc: renesas: rcar-sysc: Add support for R-Car D3 power areas
>   soc: renesas: rcar-rst: Add support for R-Car D3

Thanks, applied for v4.14.
