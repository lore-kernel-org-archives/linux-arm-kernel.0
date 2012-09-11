From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 11 Sep 2012 04:27:56 +0000
Subject: [PATCHv5 9/9] arm: vt8500: clk: Add Common Clock Framework support
In-Reply-To: <20120910211209.20289.6795@nucleus>
References: <1346626896-23070-1-git-send-email-linux@prisktech.co.nz>
 <20120910211209.20289.6795@nucleus>
Message-ID: <1347337867.2134.2.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-10 at 14:12 -0700, Mike Turquette wrote:
> Quoting Tony Prisk (2012-09-02 16:01:36)
> > This patch adds common clock framework support for arch-vt8500.
> > Support for PLL and device clocks on VT8500, WM8505 and WM8650
> > are included.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> > Changes made as per Mike's review.
> > Split endisable() into enable/disable.
> > Style tidy up - remove extra blank lines.
> 
> Hi Tony,
> 
> This looks good.  I've taken it into clk-next for some testing.
> 
> Regards,
> Mike

Presumably this patch wouldn't apply cleanly unless you also added patch
6/9. Can you let me know how you handled it so I can work with Arnd to
get all the other patches in through arm-soc.

Regards,
Tony P
