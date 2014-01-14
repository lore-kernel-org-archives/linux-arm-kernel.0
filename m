From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 14 Jan 2014 07:30:46 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIHVzYjogY2hpcGlkZWE6IHVzYm1pc2M6IEFkZCBz?=
 =?UTF-8?B?dXBwb3J0IGZvciBpLk1YMjcvaS5NWDMxIENQVXM=?=
In-Reply-To: <20140113213146.GM29475@pengutronix.de>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1389448908.753471404@f40.i.mail.ru>
 <20140113213146.GM29475@pengutronix.de>
Message-ID: <1389670245.433347746@f385.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 13 ?????? 2014, 22:31 +01:00 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Sat, Jan 11, 2014 at 06:01:48PM +0400, Alexander Shiyan wrote:
> > ???????, 11 ?????? 2014, 13:55 +01:00 ?? Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > > On Mon, Nov 11, 2013 at 11:09:16AM +0400, Alexander Shiyan wrote:
> > > > Hello.
> > > > 
> > > > > >>>> On Sunday, November 10, 2013 03:18 PM, Alexander Shiyan wrote:
> > > > > >>>>> This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.
> > > > > >>>>>
> > > > > >>>>> Signed-off-by: Alexander Shiyan<shc_work@mail.ru>
> > > > > >>>>> ---
> > > > > >>>>>     drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
> > > > > >>>>>     1 file changed, 42 insertions(+)
> > > > ...
> > > > > At this point might be good to patch the imx27.dtsi with the usb defines.
> > > > ...
> > > > 
> > > > I have a working configuration for i.MX27 USB, but I prefer to make a few more
> > > > tests before the addition of definitions in DTS. This will be a next step.
> > > > Thanks.
> > > Any news here?
> > 
> > Not ready yet.
> Are you still working at it? Would you mind sharing more details, like
> your current tree/patch stack and what works/doesn't work for you?


Now my work on this is suspended, but will continue later.
I'll send you a personal letter with DT configuration.
Ports (both Host & OTG) are detected by kernel, but works Host only.
OTG not works nor as Host, nor as Device...

---
