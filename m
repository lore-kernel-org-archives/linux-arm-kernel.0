From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 10 Jun 2016 16:49:56 +0200
Subject: [PATCH] ARM: dts: at91: ma5d4: properly define crystals
 frequencies
In-Reply-To: <1465342279-9193-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465342279-9193-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160610144956.GB19050@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2016 at 01:31:19 +0200, Alexandre Belloni wrote :
> The Denx MA5D4 dts doesn't properly define the slow_xtal and main_xtal
> frequencies, the PMC then has to fallback to using the RC oscillators whose
> precision is not really good.
> 
> As both crystals are populated, define their frequencies, see p17 of
> http://www.denx-cs.de/sites/all/files/MA5D4.HWM_.002.pdf
> 
> Also, remove the obsolete main_clock definition.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
Applied.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
