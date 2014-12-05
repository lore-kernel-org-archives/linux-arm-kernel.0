From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Dec 2014 22:40:29 +0100
Subject: [PATCH] clk: rockchip: Add CLK_SET_RATE_PARENT to sclk_uart clocks
In-Reply-To: <1417728785-18054-1-git-send-email-dianders@chromium.org>
References: <1417728785-18054-1-git-send-email-dianders@chromium.org>
Message-ID: <5769551.kTdgyxWvD4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. Dezember 2014, 13:33:05 schrieb Doug Anderson:
> We'd like to be able to set the clock rate of the sclk_uart clocks and
> actually be able to achieve clock rates greater than 24MHz.  To do
> this we need to be able to pass rate changes upward.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

applied this to my wip clk branch for 3.20 (on github)


Thanks
Heiko
