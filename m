From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Mar 2013 10:58:27 +0200
Subject: [PATCH v11 6/9] usb: chipidea: add vbus regulator control
In-Reply-To: <20130308085201.GC22550@nchen-desktop>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
 <20130306112916.GT28587@arwen.pp.htv.fi>
 <20130307024102.GD20470@nchen-desktop>
 <20130307095248.GL9171@arwen.pp.htv.fi>
 <20130308062757.GB16076@nchen-desktop>
 <20130308072624.GF21589@arwen.pp.htv.fi>
 <20130308083245.GB22550@nchen-desktop>
 <20130308084235.GM21589@arwen.pp.htv.fi>
 <20130308085201.GC22550@nchen-desktop>
Message-ID: <20130308085827.GO21589@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 04:52:02PM +0800, Peter Chen wrote:
> On Fri, Mar 08, 2013 at 10:42:35AM +0200, Felipe Balbi wrote:
> > 
> > > Second, why you think it is a broken patch, it just follows current
> > > framework. Besides, if you have concerns about DT stuff for chipidea
> > > core, why not mention it when sasche added dr_mode and phy_mode at
> > > that time?
> > 
> > Well, people make mistakes, right ? That was my mistake, but it doesn't
> > we have to let the mistake proliferate.
> > 
> 
> That means I need to post below two patches before this patchset can
> be accepted.
> 
> - Let udc-core know vbus
> - Convert platform data to DT for chipidea core driver

right, ask for help if you need but don't try to deliver patches which
are conceptually wrong.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/87a201c3/attachment-0001.sig>
