From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 4 Oct 2011 12:51:54 +0100
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4E8AF090.4070304@ti.com>
References: <4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
	<20110930102849.GA4195@opensource.wolfsonmicro.com>
	<20110930104820.GE2085@sirena.org.uk> <4E85A34E.9070203@ti.com>
	<20110930121844.GI5366@opensource.wolfsonmicro.com>
	<4E8A9988.3080907@ti.com>
	<20111004101846.GD3250@opensource.wolfsonmicro.com>
	<4E8AF090.4070304@ti.com>
Message-ID: <20111004115153.GL3250@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 05:10:00PM +0530, Rajendra Nayak wrote:
> On Tuesday 04 October 2011 03:48 PM, Mark Brown wrote:

> >This seems fairly straightforward though it will require some changes
> >within Linux, all we have to do is have the regulators name their
> >supplies.

> through dt? thats what the original bindings was doing.

I wouldn't expect it done through DT (except for things like the fixed
voltage regulator) - the driver should just know.
