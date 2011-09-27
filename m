From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Sep 2011 17:13:27 +0100
Subject: [PATCH 5/9] regulator: helper routine to extract
	fixed_voltage_config
In-Reply-To: <4E81E25C.5080500@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-6-git-send-email-rnayak@ti.com>
	<20110927121622.GD4289@opensource.wolfsonmicro.com>
	<4E81E25C.5080500@ti.com>
Message-ID: <20110927161327.GP4289@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 08:19:00PM +0530, Rajendra Nayak wrote:
> On Tuesday 27 September 2011 05:46 PM, Mark Brown wrote:
> >On Tue, Sep 27, 2011 at 03:42:48PM +0530, Rajendra Nayak wrote:

> >>+Optional properties:
> >>+- regulator-fixed-supply: Name of the regulator supply

> >This is going to be confusing with respect to the generic regulator
> >supply property.

> Yes, I guess. Any suggestions on how to make it less
> confusing? :-)

Call it display-name or something?
