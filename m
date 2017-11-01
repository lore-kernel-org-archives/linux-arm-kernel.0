From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 Nov 2017 09:31:03 +0100
Subject: [PATCH 0/3] arm64: dts: renesas: eagle: Add watchdog timer support
In-Reply-To: <1509378989-25069-1-git-send-email-geert+renesas@glider.be>
References: <1509378989-25069-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20171101083102.aaaylqkfid7wigov@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 04:56:26PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds support for the watchdog timer on R-Car V3M, and
> enables it on the Eagle development board.
> 
> This allows to use the watchdog timer to reset the board, until PSCI is
> enhanced to include such functionality.
> 
> Dependencies:
>   - renesas-devel-20171030-v4.14-rc7,
>   - "[PATCH] dt-bindings: watchdog: renesas-wdt: Add support for the
>      r8a77970 wdt", which is a trivial addition.

Thanks, I agree that binding change is trivial and furthermore I see
that its been heavily Acked. I have gone ahead and applied this series.
