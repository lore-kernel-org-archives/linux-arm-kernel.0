From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 21 Oct 2010 18:43:01 +0200
Subject: [PATCH 1/2] mmc: quirk fix for timeout problem
In-Reply-To: <AANLkTinairUcKpTH2ePjbp3j7qdsmrPCeeWR_E+RSsPU@mail.gmail.com>
References: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>
	<1287566576-1224-1-git-send-email-shawn.gsc@gmail.com>
	<20101020112741.GB10261@pengutronix.de>
	<AANLkTinairUcKpTH2ePjbp3j7qdsmrPCeeWR_E+RSsPU@mail.gmail.com>
Message-ID: <20101021164301.GA11131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 22, 2010 at 12:11:56AM +0800, Shawn Guo wrote:
> Hi Wolfram,
> 
> On Wed, Oct 20, 2010 at 7:27 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > On Wed, Oct 20, 2010 at 05:22:56PM +0800, Shawn Guo wrote:
> >> This patch is to fix timeout problem which was seen on babbage.
> >> Thanks Richard Zhu <r65037@freescale.com> for catching this.
> >>
> >> Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>
> >
> > NACK. It is still untested if we need that quirk on MX25/35.
> > Eric wanted to send an updated patch next week.
> >
> 
> I just tested the code change on mx35_3ds and mx25_3ds, and no problem
> was seen.  I will send the patch for mmc support on mx35_3ds and
> mx25_3ds soon.

The question is more if they work _without_ the additional quirk.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101021/dd3ed0ab/attachment.sig>
