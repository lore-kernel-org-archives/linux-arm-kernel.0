From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 31 Aug 2018 10:05:31 +0200
Subject: [PATCH 1/7] clk: rockchip: improve rk3288 pll rates for better
 hdmi output
In-Reply-To: <20180828185513.13216-2-urjaman@gmail.com>
References: <20180828185513.13216-1-urjaman@gmail.com>
 <20180828185513.13216-2-urjaman@gmail.com>
Message-ID: <4726810.oPXn6dVjrD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. August 2018, 20:55:07 CEST schrieb Urja Rannikko:
> Add and correct PLL rates for better hdmi output.
> 
> This includes minimizing jitter on 213 MHz for better 71 MHz,
> 250.5 MHz for better 83.5 MHz, 428 MHz for better 25.175 Mhz,
> low jitter 273 MHz for better 68.25 mhz, 356 MHz for better 118.68 Mhz
> and 300MHz.
> 
> Increase the used Fvco for 308, 324 MHz, 292.5 MHz, 273.6 MHz,
> 238 MHz and 216 MHz.
> 
> And add some additional rates allowing to reach better hdmi-related
> rates in general.
> 
> These match the rates used by ChromeOS, so have been quite widely tested.
> 
> Signed-off-by: Urja Rannikko <urjaman@gmail.com>

applied for 4.20

Thanks
Heiko
