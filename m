From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 19:25:02 +0000
Subject: [PATCH] ARM: vt8500: clk: Add clock support for arch-vt8500
In-Reply-To: <1342969400-21123-1-git-send-email-linux@prisktech.co.nz>
References: <1342969400-21123-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201207241925.02594.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 July 2012, Tony Prisk wrote:
> 
> This patch adds common clock framework support for arch-vt8500.
> WM8650 support is included in preparation for devicetree support.
> Each SoC has a seperate initialization function due to no
> devicetree support to identify SoCs at the moment. Once devicetree
> is implemented, VT8500 and WM8505 should be combined. WM8650 uses
> different functions for clocks.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

arch/arm parts:

Acked-by: Arnd Bergmann <arnd@arndb.de>
