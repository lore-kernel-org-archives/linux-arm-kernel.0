From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 30 Jul 2012 09:00:32 -0700
Subject: [PATCH 00/12] chipidea/imx: add otg support and some bug fix
In-Reply-To: <20120730091757.GH3347@b20223-02.ap.freescale.net>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
 <20120717004057.GA25562@kroah.com>
 <20120719020553.GO21635@b20223-02.ap.freescale.net>
 <20120726105947.GW21635@b20223-02.ap.freescale.net>
 <20120730091757.GH3347@b20223-02.ap.freescale.net>
Message-ID: <20120730160032.GA28703@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 05:17:58PM +0800, Richard Zhao wrote:
> On Thu, Jul 26, 2012 at 06:59:48PM +0800, Richard Zhao wrote:
> > On Thu, Jul 19, 2012 at 10:05:54AM +0800, Richard Zhao wrote:
> > > On Mon, Jul 16, 2012 at 05:40:57PM -0700, Greg KH wrote:
> > > > On Thu, Jul 12, 2012 at 03:01:40PM +0800, Richard Zhao wrote:
> > > > > The patch set is tested on imx6q_sabrelite board.
> > > > > 
> > > > > The patch can also be found at
> > > > > https://github.com/riczhao/kernel-imx/commits/topics/usb-driver
> > > > > 
> > > > > For test which merged platform patches:
> > > > > https://github.com/riczhao/kernel-imx/commits/topics/usb-test
> > > > > 
> > > > > It's better apply after patch I sent out:
> > > > > usb: chipidea: cleanup dma_pool if udc_start() fails
> > > > 
> > > > I need acks from Alexander before I can accept any of these.
> > > ping Alexander ...
> > ping Alexander again ...
> Hi Greg,
> 
> Is there a better way but keeping waiting?

It's the middle of the merge window, even if Alexander shows up right
now, I can't do anything with these patches until 3.6-rc1 is out.

So be patient, this is vacation time for lots of people.

greg k-h
