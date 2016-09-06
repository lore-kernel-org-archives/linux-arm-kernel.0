From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2016 07:31:25 +0200
Subject: [PATCH 1/3] ARM: dts: armv7-m: remove skeleton.dtsi include
In-Reply-To: <20160830205250.15616-2-manabian@gmail.com>
References: <20160830205250.15616-1-manabian@gmail.com>
 <20160830205250.15616-2-manabian@gmail.com>
Message-ID: <20160906053125.3b5ynj5g4wnx34lb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 10:52:48PM +0200, Joachim Eastwood wrote:
> Remove skeleton.dtsi from the common ARM Cortex-M dtsi. This will allow
> us to remove skeleton.dtsi on a per platform basis and get rid of the
> unit address warning on the memory nodes without getting duplicate memory
> nodes.
> 
> See 3ebee5a2e141 ("arm64: dts: kill skeleton.dtsi") for additional
> reasons not to use the skeleton.dtsi.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
