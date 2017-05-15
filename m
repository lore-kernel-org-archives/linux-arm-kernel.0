From: robh@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 16:44:55 -0500
Subject: [PATCH v2 1/3] watchdog: bindings: dw_wdt: add reset lines
In-Reply-To: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
References: <cover.e174fd0fa926fadf54e0f76e07f238bed3e162fc.1494595189.git-series.s.trumtrar@pengutronix.de>
 <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
Message-ID: <20170515214455.f7jorcqou4oyvnkq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 03:34:35PM +0200, Steffen Trumtrar wrote:
> Document the reset lines holding the watchdog core in reset.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-watchdog at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> ---
>  Documentation/devicetree/bindings/watchdog/dw_wdt.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
