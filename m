From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 24 Jul 2012 14:07:35 -0700
Subject: [PATCH] ARM: vt8500: clk: Add clock support for arch-vt8500
In-Reply-To: <1342969400-21123-1-git-send-email-linux@prisktech.co.nz>
References: <1342969400-21123-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CAJOA=zNNE18DWwSgfh0H0zGgqpFhPeZrZ8zc0i_cxPBUc2VuoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 8:03 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> This patch adds common clock framework support for arch-vt8500.
> WM8650 support is included in preparation for devicetree support.
> Each SoC has a seperate initialization function due to no
> devicetree support to identify SoCs at the moment. Once devicetree
> is implemented, VT8500 and WM8505 should be combined. WM8650 uses
> different functions for clocks.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Hi Tony,

I'll give this a more thorough review once the -rc1 window is over.

Regards,
Mike
