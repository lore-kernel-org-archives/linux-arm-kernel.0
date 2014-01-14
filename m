From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 14 Jan 2014 14:49:42 +0100
Subject: [PATCH 1/2] usb: chipidea: usbmisc: Add support for
 i.MX27/i.MX31 CPUs
In-Reply-To: <52D4B4CB.6050609@gtsys.com.hk>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1389448908.753471404@f40.i.mail.ru>
 <20140113213146.GM29475@pengutronix.de>
 <1389670245.433347746@f385.i.mail.ru>
 <52D4B4CB.6050609@gtsys.com.hk>
Message-ID: <20140114134942.GY29475@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

On Tue, Jan 14, 2014 at 11:53:47AM +0800, Chris Ruehl wrote:
> On Tuesday, January 14, 2014 11:30 AM, Alexander Shiyan wrote:
> >???????????, 13 ?????? 2014, 22:31 +01:00 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >>On Sat, Jan 11, 2014 at 06:01:48PM +0400, Alexander Shiyan wrote:
> >>>???????, 11 ?????? 2014, 13:55 +01:00 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >>>>On Mon, Nov 11, 2013 at 11:09:16AM +0400, Alexander Shiyan wrote:
> >>>>>Hello.
> >>>>>
> >>>>>>>>>>On Sunday, November 10, 2013 03:18 PM, Alexander Shiyan wrote:
> >>>>>>>>>>>This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.
> >>>>>>>>>>>
> >>>>>>>>>>>Signed-off-by: Alexander Shiyan<shc_work@mail.ru>
> >>>>>>>>>>>---
> >>>>>>>>>>>     drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
> >>>>>>>>>>>     1 file changed, 42 insertions(+)
> >>>>>...
> >>>>>>At this point might be good to patch the imx27.dtsi with the usb defines.
> >>>>>...
> >>>>>
> >>>>>I have a working configuration for i.MX27 USB, but I prefer to make a few more
> >>>>>tests before the addition of definitions in DTS. This will be a next step.
> >>>>>Thanks.
> >>>>Any news here?
> >>>Not ready yet.
> >>Are you still working at it? Would you mind sharing more details, like
> >>your current tree/patch stack and what works/doesn't work for you?
> >
> >Now my work on this is suspended, but will continue later.
> >I'll send you a personal letter with DT configuration.
> >Ports (both Host & OTG) are detected by kernel, but works Host only.
> >OTG not works nor as Host, nor as Device...
> >
> >---
> hi,
> I'm still working on my patches for imx27 and ULPI integration.  But
> have more urgent things in the queue.

Starting from here I'm not sure I understand you.
> I have a running version but it cant make it in the kernel. Rework
> on platform device code needed.
> Just wait until the patches already accepted appears in the
> linux-next before commit new patches.

That means: USB works for you? What does "it cant make it in the kernel"
mean? Problems to upstream it?
Do you wait or should I?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
