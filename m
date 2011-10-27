From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 Oct 2011 10:08:47 +0100
Subject: [PATCH v3 0/4] Device tree support for regulators
In-Reply-To: <1319702185-16108-1-git-send-email-rnayak@ti.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
Message-ID: <20111027090847.GC6641@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:26:21PM +0530, Rajendra Nayak wrote:

> v3 is based on the latest devicetree/next and is tested
> (with twl adaptaions, which will be posted seperately)
> on the OMAP4 panda and OMAP4 sdp boards.

Looking at the device bindings I notice that these bindings loose the
ability to assign a descriptive name to regulator outputs.  This is
really useful for making it easy to tie the code and the schematics
together - you can make the runing system use the same name as the
schematic.
