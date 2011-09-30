From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Sep 2011 11:49:47 +0100
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4E85768C.6050601@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com> <4E85768C.6050601@ti.com>
Message-ID: <20110930104947.GF2085@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 09:58:04AM +0200, Cousson, Benoit wrote:

> I think as well that we should avoid considering a regulator with
> several outputs. I saw the same pattern used for the clock binding
> in DT as well.

This binding is for the consumer side, not the producer side.  A binding
which restricted us to a single consumer per regulator would obviously
not work for real systems.
