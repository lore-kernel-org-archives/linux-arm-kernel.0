From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 7 Apr 2014 16:12:01 -0500
Subject: [PATCH 3/3] ARM: socfpga: dts: add reset-controller
In-Reply-To: <1396629087-23727-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396629087-23727-4-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396905121.25236.2.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-04-04 at 18:31 +0200, Steffen Trumtrar wrote:
> Add the necessary #reset-cells property to the rst-mgr node and
> provide a header-file with all possible resets specified.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi           |  8 ++-
>  include/dt-bindings/reset/altr,rst-mgr.h | 90 ++++++++++++++++++++++++++++++++

Does this file belong under dt-bindings/reset/ or
dt-bindings/reset-controller/?

Dinh
