From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Wed, 29 May 2013 11:36:04 +0200
Subject: [PATCH v2] usb: musb: fix clock naming
In-Reply-To: <20130528173637.GE15794@arwen.pp.htv.fi>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
 <20130528173637.GE15794@arwen.pp.htv.fi>
Message-ID: <1369820164.6673.55.camel@polaris.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-05-28 at 20:36 +0300, Felipe Balbi wrote: 
> On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists at googlemail.com wrote:
> > From: Yegor Yefremov <yegorslists@googlemail.com>
> > 
> > 'ick' was changed to 'hsotgusb_ick'
> > 'fck' was changed to 'hsotgusb_fck'
> > 
> > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> NAK. Fix your clock data.

Yegor, I'm not sure how my signed-off-by got here. It seems that you
picked the patch up from this thread:
http://marc.info/?l=linux-omap&m=134390141101734

Note that my mail contains no signed-off-by and the change is described
as a work around.

Regards,
Jan
