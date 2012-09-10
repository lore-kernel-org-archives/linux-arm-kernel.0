From: mturquette@ti.com (Mike Turquette)
Date: Mon, 10 Sep 2012 14:12:09 -0700
Subject: [PATCHv5 9/9] arm: vt8500: clk: Add Common Clock Framework support
In-Reply-To: <1346626896-23070-1-git-send-email-linux@prisktech.co.nz>
References: <1346626896-23070-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20120910211209.20289.6795@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Prisk (2012-09-02 16:01:36)
> This patch adds common clock framework support for arch-vt8500.
> Support for PLL and device clocks on VT8500, WM8505 and WM8650
> are included.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> Changes made as per Mike's review.
> Split endisable() into enable/disable.
> Style tidy up - remove extra blank lines.

Hi Tony,

This looks good.  I've taken it into clk-next for some testing.

Regards,
Mike
