From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 14 Mar 2018 00:38:40 +0100
Subject: [PATCH] clk: rockchip: Add 1.6GHz PLL rate
In-Reply-To: <20180313203719.75639-1-dbasehore@chromium.org>
References: <20180313203719.75639-1-dbasehore@chromium.org>
Message-ID: <13704601.M15qmmjcHi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 13. M?rz 2018, 21:37:19 CET schrieb Derek Basehore:
> We need this rate to generate 100, 200, and 228.57MHz from the same
> PLL. 228.57MHz is useful for a pixel clock when the VPLL is used for
> and external display.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>

applied for 4.17

Thanks
Heiko
