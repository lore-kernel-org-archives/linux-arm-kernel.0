From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 26 Jul 2012 18:59:48 +0800
Subject: [PATCH 00/12] chipidea/imx: add otg support and some bug fix
In-Reply-To: <20120719020553.GO21635@b20223-02.ap.freescale.net>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
 <20120717004057.GA25562@kroah.com>
 <20120719020553.GO21635@b20223-02.ap.freescale.net>
Message-ID: <20120726105947.GW21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 10:05:54AM +0800, Richard Zhao wrote:
> On Mon, Jul 16, 2012 at 05:40:57PM -0700, Greg KH wrote:
> > On Thu, Jul 12, 2012 at 03:01:40PM +0800, Richard Zhao wrote:
> > > The patch set is tested on imx6q_sabrelite board.
> > > 
> > > The patch can also be found at
> > > https://github.com/riczhao/kernel-imx/commits/topics/usb-driver
> > > 
> > > For test which merged platform patches:
> > > https://github.com/riczhao/kernel-imx/commits/topics/usb-test
> > > 
> > > It's better apply after patch I sent out:
> > > usb: chipidea: cleanup dma_pool if udc_start() fails
> > 
> > I need acks from Alexander before I can accept any of these.
> ping Alexander ...
ping Alexander again ...
