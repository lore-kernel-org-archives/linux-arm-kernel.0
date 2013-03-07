From: mporter@ti.com (Matt Porter)
Date: Thu, 7 Mar 2013 09:51:12 -0500
Subject: [PATCH 2/2] ARM: dts: add AM33XX MMC support
In-Reply-To: <20130307144656.GR6209@beef>
References: <1362629799-22485-1-git-send-email-mporter@ti.com>
 <1362629799-22485-3-git-send-email-mporter@ti.com>
 <41fde401c8e646689123d7c6d3a2dffc@DLEE71.ent.ti.com>
 <20130307141235.GQ6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
 <20130307144656.GR6209@beef>
Message-ID: <20130307145112.GS6209@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 09:46:56AM -0500, Matt Porter wrote:
> On Thu, Mar 07, 2013 at 02:39:55PM +0000, Vaibhav Hiremath wrote:
> > 2. And MMC rootFS mount is __not__ working for me.
> > 
> > 3. I get following error message - 
> > 
> > [    2.118207] omap_hsmmc mmc.3: unable to obtain RX DMA engine channel 25
> 
> See below, you don't have CONFIG_EDMA on most likely.

That's CONFIG_TI_EDMA, of course.

-Matt
