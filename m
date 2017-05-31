From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 12:01:04 +0200
Subject: [PATCH v3] ARM: dts: at91: sama5d2_xplained: add pwm controller
In-Reply-To: <1496222592-19375-1-git-send-email-claudiu.beznea@microchip.com>
References: <1496222592-19375-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170531100104.ol6gkredbncq52kl@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/2017 at 12:23:12 +0300, Claudiu Beznea wrote:
> Add pwm controller bindings for sama5d2_xplained
> and enable it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> Changes in v3:
> - enable pwm in at91-sama5d2_xplained.dts file
> 
> Changes in v2:
> - Correct the typo in patch subject.
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 4 ++++
>  arch/arm/boot/dts/sama5d2.dtsi              | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
