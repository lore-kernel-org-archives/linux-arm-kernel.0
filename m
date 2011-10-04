From: rnayak@ti.com (Nayak, Rajendra)
Date: Tue, 4 Oct 2011 18:10:57 +0530
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111004121152.GB6934@opensource.wolfsonmicro.com>
References: <4E854532.6080605@ti.com>
	<20110930102849.GA4195@opensource.wolfsonmicro.com>
	<20110930104820.GE2085@sirena.org.uk> <4E85A34E.9070203@ti.com>
	<20110930121844.GI5366@opensource.wolfsonmicro.com>
	<4E8A9988.3080907@ti.com>
	<20111004101846.GD3250@opensource.wolfsonmicro.com>
	<4E8AF090.4070304@ti.com>
	<20111004115153.GL3250@opensource.wolfsonmicro.com>
	<4E8AF5E7.8050402@ti.com>
	<20111004121152.GB6934@opensource.wolfsonmicro.com>
Message-ID: <CACYZBRH2fBqetofpwRcxZXxXuHoW5RAfYzkHy9Lts6UbAbR4Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 4, 2011 at 5:41 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> On Tue, Oct 04, 2011 at 05:32:47PM +0530, Rajendra Nayak wrote:
> > On Tuesday 04 October 2011 05:21 PM, Mark Brown wrote:
>
> > >I wouldn't expect it done through DT (except for things like the fixed
> > >voltage regulator) - the driver should just know.
>
> > something like a
> > int regulator_set_supply(struct regulator_dev *rdev, char *supply_name);
> > to be called from drivers makes sense?
>
> Just put a member in the driver struct, much simpler that way, no code
> in the individual drivers.

okay, makes sense. I will add it to struct regulator_desc.
Thanks.
