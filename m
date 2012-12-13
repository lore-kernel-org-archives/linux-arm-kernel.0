From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 13 Dec 2012 13:47:18 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
References: <50C62161.9080708@wwwdotorg.org>
 <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
Message-ID: <20121213204718.GA4882@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 09:42:29PM +0100, Thierry Reding wrote:

> So I tried this today and it breaks horribly. There's some internal
> abort or something. I don't have access to the hardware right now and
> forgot to save the log output, but I can follow up in the morning. Also
> up until the abort, bus 0000:00.0 was identified as the virtual switch
> within the FPGA that's connected to port 0, so that would indicate that
> it isn't in fact compliant and neither root port is reachable via the
> regular mapping.
> 
> I suppose that may be the reason why the downstream code implements the
> special case for accesses to the root ports' configuration space.

With the special case, what does device 0:0.0 show up as? What class?

Jason
