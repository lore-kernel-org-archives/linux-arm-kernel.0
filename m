From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Jul 2014 05:50:42 -0700
Subject: [PATCH v3 0/2] arm: dts: add support for am437x sk
In-Reply-To: <20140630164543.GA31442@saruman.home>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <20140630164543.GA31442@saruman.home>
Message-ID: <20140701125041.GP28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140630 09:47]:
> Hi,
> 
> On Mon, Jun 23, 2014 at 01:20:57PM -0500, Felipe Balbi wrote:
> > Hi,
> > 
> > here's v3 of am437x sk support. Patches tested on top of next-20140617.
> > 
> > Note that this series was tested with the following extra patches:
> > 
> > http://marc.info/?l=linux-omap&m=140299431732700&w=2
> > http://marc.info/?l=linux-omap&m=140300146503126&w=2
> > http://marc.info/?l=linux-omap&m=140299231232123
> > http://marc.info/?l=linux-omap&m=140310472709968&w=2
> > http://marc.info/?l=linux-omap&m=140310471409959&w=2
> > 
> > A branch is also available with all these patches at [1].
> > 
> > [1] http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=am437x-starterkit
> > 
> > Felipe Balbi (2):
> >   arm: dts: am4372: let boards access all nodes through phandles
> >   arm: dts: add support for AM437x StarterKit
> 
> ping on this series, it has been tested by several folks and still no
> updates from anybody in the DT land.

Thanks applying both into omap-for-v3.17/dt branch.

Regards,

Tony
