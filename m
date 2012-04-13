From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 13 Apr 2012 10:46:14 +0800
Subject: [PATCH v5] Consolidate SRAM support
In-Reply-To: <20120109171801.GM2854@game.jcrosoft.org>
References: <1310300379-2882-1-git-send-email-plagnioj@jcrosoft.com>
 <20111229013551.GN15863@b20223-02.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D1214304A0B5@DBDE01.ent.ti.com>
 <20120109171801.GM2854@game.jcrosoft.org>
Message-ID: <20120413024608.GC27730@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Mon, Jan 09, 2012 at 06:18:01PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 07:23 Thu 29 Dec     , Bedia, Vaibhav wrote:
> > On Thu, Dec 29, 2011 at 07:05:52, Richard Zhao wrote:
> > > Hi Jean,
> > > 
> > > How is this patch going? Freescale imx IRAM clean up depend on it.
> > > 
> > 
> > We are using a previous version of this patch on TI's AM335x.
> > 
> > AM335x has PRU support, so merging this patch to unify the
> > Davinci and OMAP SRAM allocation schemes will help here.
> I'm going to sned a new update to the genalloc to add named poll
Will you plan to create a common sram driver getting device
info from device tree?

Thanks
Richard
> 
> Best Regards,
> J.
> 
