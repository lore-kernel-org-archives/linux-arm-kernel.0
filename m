From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 27 Nov 2014 00:32:29 +0100
Subject: [PATCH] clk: rockchip: rk3288 export i2s0_clkout for use in DT
In-Reply-To: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
References: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <3863623.tcGxuFQcZa@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. November 2014, 23:15:19 schrieb Sonny Rao:
> This exposes the clock that comes out of the i2s block which generally
> goes to the audio codec.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

applied to my clk branch after removing the CLK_SET_RATE_PARENT

Heiko
