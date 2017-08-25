From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 25 Aug 2017 10:33:51 +0200
Subject: [PATCH RESEND] rtc: sun6i: Add support for the external
 oscillator gate
In-Reply-To: <20170825074202.18743-1-maxime.ripard@free-electrons.com>
References: <20170825074202.18743-1-maxime.ripard@free-electrons.com>
Message-ID: <20170825083351.2itpzyyo6ilxt36p@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/2017 at 09:42:02 +0200, Maxime Ripard wrote:
> The RTC can output its 32kHz clock outside of the SoC, for example to clock
> a WiFi chip.
> 
> Create a new clock that other devices will be able to retrieve, while
> maintaining the DT stability by providing a default name for that clock if
> clock-output-names doesn't list one.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/sun6i-rtc.txt          |  4 ++--
>  drivers/rtc/rtc-sun6i.c                            | 24 +++++++++++++++++++---
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
