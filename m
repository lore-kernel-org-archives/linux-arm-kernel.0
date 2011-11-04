From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Nov 2011 13:21:26 -0700
Subject: [PATCH v3 0/4] Device tree support for regulators
In-Reply-To: <20111027090847.GC6641@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<20111027090847.GC6641@opensource.wolfsonmicro.com>
Message-ID: <CAOesGMii8v3DOCjWpuF3=+EVu+-HYGys=7RRgpk+9U=FxTHwOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 2:08 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Oct 27, 2011 at 01:26:21PM +0530, Rajendra Nayak wrote:
>
>> v3 is based on the latest devicetree/next and is tested
>> (with twl adaptaions, which will be posted seperately)
>> on the OMAP4 panda and OMAP4 sdp boards.
>
> Looking at the device bindings I notice that these bindings loose the
> ability to assign a descriptive name to regulator outputs. ?This is
> really useful for making it easy to tie the code and the schematics
> together - you can make the runing system use the same name as the
> schematic.

That can easily be added by having a output-name property in the
regulator device node.

-Olof
