From: max.schwarz@online.de (Max Schwarz)
Date: Sun, 23 Mar 2014 00:03:22 +0100
Subject: [PATCH] ARM: rockchip: rk3188: enable pull-ups on UART inputs
In-Reply-To: <2573614.4MaI90U1A8@diego>
References: <6599423.XddAUl3dCe@typ> <2567235.KcPFJfGIvp@typ>
 <2573614.4MaI90U1A8@diego>
Message-ID: <34897065.ss2WWxiNAl@xq-nb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

> ok, but as we change the default behaviour of the pin - and as we discussed
> above rightfully so, the commit message should reflect this and not describe
> a Radxa-Rock specific change. So would you be ok with something like:
> 
> ---------- 8< --------------------
> Subject: [PATCH] ARM: rockchip: rk3188: enable pull-ups on UART RX pins
> 
> The default behaviour of the uart-rx pins on the rk3188 is to be pulled up
> and a lot of designs use diodes to even prevent them from being raised from
> the outside.
> 
> Therefore change the rx-pin settings accordingly.
> 
> This also fixes a uart receive problem on mass production Radxa Rock boards.
> ---------- 8< --------------------

Yes, that sounds good to me. Thanks!

Cheers,
  Max
