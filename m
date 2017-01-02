From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 16:59:35 +0530
Subject: [PATCH v7 5/5] ARM: dts: da850: specify the maximum pixel clock
 rate for tilcdc
In-Reply-To: <1481623759-12786-6-git-send-email-bgolaszewski@baylibre.com>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
 <1481623759-12786-6-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <778cfd63-823c-7bf6-dc9d-0f2dcb43e129@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 December 2016 03:39 PM, Bartosz Golaszewski wrote:
> At maximum CPU frequency of 300 MHz the maximum pixel clock frequency
> is 37.5 MHz[1]. We must filter out any mode for which the calculated
> pixel clock rate would exceed this value.
> 
> Specify the max-pixelclock property for the display node for
> da850-lcdk.
> 
> [1] http://processors.wiki.ti.com/index.php/OMAP-L1x/C674x/AM1x_LCD_Controller_(LCDC)_Throughput_and_Optimization_Techniques

This wiki page is not really a TI datasheet and can change without
notice. I changed this to refer to
http://www.ti.com/lit/ds/symlink/am1808.pdf (SPRS653E, revised March
2014), table 6-110.

Applied to v4.11/dt

Thanks,
Sekhar
