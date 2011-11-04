From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Nov 2011 21:02:41 +0000
Subject: [PATCH v3 0/4] Device tree support for regulators
In-Reply-To: <CAOesGMii8v3DOCjWpuF3=+EVu+-HYGys=7RRgpk+9U=FxTHwOA@mail.gmail.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<20111027090847.GC6641@opensource.wolfsonmicro.com>
	<CAOesGMii8v3DOCjWpuF3=+EVu+-HYGys=7RRgpk+9U=FxTHwOA@mail.gmail.com>
Message-ID: <20111104210241.GB2541@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 01:21:26PM -0700, Olof Johansson wrote:
> On Thu, Oct 27, 2011 at 2:08 AM, Mark Brown

> > Looking at the device bindings I notice that these bindings loose the
> > ability to assign a descriptive name to regulator outputs. ?This is
> > really useful for making it easy to tie the code and the schematics
> > together - you can make the runing system use the same name as the
> > schematic.

> That can easily be added by having a output-name property in the
> regulator device node.

Which is pretty much what Rajendra's updated version in response to my
above comment did FWIW.
