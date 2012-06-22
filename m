From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 22 Jun 2012 13:04:18 -0600 (MDT)
Subject: [PATCH 04/11] mfd: omap-usb: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-5-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-5-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1206221302470.10198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> In preparation of OMAP moving to Common Clk Framework (CCF) add clk_prepare()
> and clk_unprepare() for the various usb host clocks.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Looks like this one will be at least partially obsoleted by this series:

ARM: OMAP: TLL driver implementation for USB host driver
http://marc.info/?l=linux-omap&m=134019432606399&w=2

and the runtime PM conversion in that series needs to be done anyway.


- Paul
