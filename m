From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 30 Jun 2013 12:16:32 +0200
Subject: [PATCH v3 1/5] rtc: mxc_rtc: Driver rework
In-Reply-To: <1372583433.705420573@f307.mail.ru>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
 <1372541615.220890134@f402.i.mail.ru>
 <20130630080546.GS516@pengutronix.de>
 <1372583433.705420573@f307.mail.ru>
Message-ID: <20130630101632.GT516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 30, 2013 at 01:10:33PM +0400, Alexander Shiyan wrote:
> > > > > On Sat, Jun 29, 2013 at 12:40:40PM +0400, Alexander Shiyan wrote:
> > > > > > This patch rework mxc_rtc driver.
> > > > > > Major changes have been made:
> > > > > > - Added second clock support (optional) which permit module functionality.
> > > > > > - Implemented support for periodic interrupts.
> > > > > > - Some code have been optimized.
> > > > > 
> > > > > You won't get any further with this if you don't listen to comments.
> > > > > 
> > > > > We're at v3 and Still this patch combines many totally unrelated changes
> > > > > in a single patch. This was noted by Shawn and more detailed by myself.
> > > > 
> > > > Where Sascha?
> > > > v3 is so different than v2. Can you inline your comments in v3?
> > 
> > I just did that.
> > 
> > > 
> > > At the moment, the driver does not work at all, even for a boards which declared.
> > > I do not understand the issue of making changes if we can correct this situation 
> > > Please fix me.
> > > Once again, now driver not work at all .....
> > 
> > If the driver is really so broken and ugly that it can't be fixed or
> > only with a huge amount of work, then your option would be to replace it
> > completely and clearly say why you think it's broken and why we need a
> > new driver.
> > 
> > I don't think that's the case. The driver has it's deficiencies, but
> > they can be fixed. Many of your changes are fine, but it's really 5-10
> > patches you have thrown into a single patch.
> > This is simply not nice to people reviewing it.
> 
> The situation is this: I do not use this device in their work, I just wanted to
> add the driver to the DT-tree, respectively I had to check if it works.
> Well, I got around to it, and the result was a series of patches to achieve the
> ultimate goal - RTC DT-node.
> The driver has not been updated for a long time and is very bad that my efforts
> were in vain verification. On my opinion, any changes it is better than inaction.
> Well, leave it to the discretion of the community.

Most of your patches are fine, it's just that the first one does too
much in a single patch and it would be easy to split that up.

Anyway, I'm not the one applying it. If anyone thinks I'm too picky here
just rule me out.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
