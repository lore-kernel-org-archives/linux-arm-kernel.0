From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 24 Sep 2012 21:00:47 +0200
Subject: [PATCH 2/2] ARM i.MX25: Add devicetree
In-Reply-To: <1348468841-4331-3-git-send-email-s.hauer@pengutronix.de>
References: <1348468841-4331-1-git-send-email-s.hauer@pengutronix.de>
 <1348468841-4331-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120924190046.GA4439@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Sep 24, 2012 at 08:40:40AM +0200, Sascha Hauer wrote:
> This adds a i.MX25 dtsi file along with the i.MX25 clock tree
> documentation. The devicetree should be fairly complete for:
> 
> - uart
> - fec
> - i2c
> - spi
> - pwm
> - nand
> - gpio
> - wdog
> - esdhc
> - flexcan
> 
> The more exotic devices currently miss clock bindings.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

[...]

> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.  The following is a full list of i.MX6Q
> +clocks and IDs.

s/i.MX6Q/i.MX25/

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
