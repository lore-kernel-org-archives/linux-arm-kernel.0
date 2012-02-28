From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 28 Feb 2012 11:11:48 +0530
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
In-Reply-To: <20120227145345.GJ3191@opensource.wolfsonmicro.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
 <20120227134112.GB3191@opensource.wolfsonmicro.com> <4F4B8A85.7060603@ti.com>
 <20120227140356.GF3191@opensource.wolfsonmicro.com> <4F4B9166.7020909@ti.com>
 <20120227145345.GJ3191@opensource.wolfsonmicro.com>
Message-ID: <4F4C691C.2000600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 February 2012 08:23 PM, Mark Brown wrote:
> If adding device tree support breaks existing platforms something is
> going wrong, while you're pulling things together device tree might not
> work until all the support makes it in but the old non-DT code should
> continue to function.

Adding device tree support will not break existing platforms. The
non-DT code will function as expected. The dependencies I mentioned
were only with the dtsi/dts files that patch 2 was updating. The driver
changes have no dependencies with any other DT series. I will repost
all of Tero/Peter and my changes (to add DT support to the driver) as
one single series and drop the dts file updates, which I guess can go
via Tony/OMAP tree.

>
