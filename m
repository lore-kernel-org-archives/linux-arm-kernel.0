From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 11 Sep 2012 20:50:58 +0000
Subject: [PATCHv5 9/9] arm: vt8500: clk: Add Common Clock Framework support
In-Reply-To: <20120911175541.20289.95694@nucleus>
References: <1346626896-23070-1-git-send-email-linux@prisktech.co.nz>
 <20120910211209.20289.6795@nucleus> <1347337955.2134.3.camel@gitbox>
 <20120911175541.20289.95694@nucleus>
Message-ID: <1347396847.2141.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-11 at 10:55 -0700, Mike Turquette wrote:
> Quoting Tony Prisk (2012-09-10 21:32:35)
> > On Mon, 2012-09-10 at 14:12 -0700, Mike Turquette wrote:
> > > Quoting Tony Prisk (2012-09-02 16:01:36)
> > > > This patch adds common clock framework support for arch-vt8500.
> > > > Support for PLL and device clocks on VT8500, WM8505 and WM8650
> > > > are included.
> > > > 
> > > > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > > > ---
> > > > Changes made as per Mike's review.
> > > > Split endisable() into enable/disable.
> > > > Style tidy up - remove extra blank lines.
> > > 
> > > Hi Tony,
> > > 
> > > This looks good.  I've taken it into clk-next for some testing.
> > > 
> > > Regards,
> > > Mike
> > 
> > Presumably this patch wouldn't apply cleanly unless you also added patch
> > 6/9. Can you let me know how you handled it so I can work with Arnd to
> > get all the other patches in through arm-soc.
> > 
> 
> I see no dependency between patch #9 and #6.  This patch simply
> introduces a new C file and adds an entry into drivers/clk/Makefile.  Am
> I missing something?
> 
> Also, I did not push my clk-next branch out publicly last night with
> this change so it is no problem for me to drop it.  Would you prefer the
> whole series go through arm-soc?  If so this patch has my:
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>
> 
> Regards,
> Mike
> 
> > Regards,
> > Tony P

Mike,

Sorry - I got that backwards - patch 6 has a dependency on this patch.
It would definitely be easier for the whole lot to go through arm-soc
since you're okay with that.

Thanks for your time.

Regards

Tony P
