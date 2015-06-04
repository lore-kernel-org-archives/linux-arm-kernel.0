From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 5 Jun 2015 00:22:08 +0200
Subject: [PATCH 2/2] rtc: mxc: add support of device tree
In-Reply-To: <5570C26D.5080204@gmail.com>
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
 <1431729330-7625-3-git-send-email-tremyfr@gmail.com>
 <20150528120601.GO2185@piout.net> <5570C26D.5080204@gmail.com>
Message-ID: <20150604222208.GE713@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2015 at 23:26:05 +0200, Philippe Reynes wrote :
> I'll do it in the next version of this patch.
> >>+	} else
> >>+		pdata->devtype = pdev->id_entry->driver_data;
> >>
> >
> 
> Do you prefer that I wait the clock driver has move to drivers/clk/imx
> (as requested by Shawn) before sending a v2 ?
> 

It would have been good to get the clock change in 4.2 but it is already
late in the cycle now so I'm not sure it can go in. That would have
removed the dependency.

The other solution is to merge everything through Shawn's tree.

Anyway, you can send the patches, we'll handle that part :)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
