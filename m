From: balbi@ti.com (Felipe Balbi)
Date: Wed, 29 May 2013 20:41:44 +0300
Subject: [PATCH v2] usb: musb: fix clock naming
In-Reply-To: <CAGm1_ks7Y8n1xKA=qiCCFcxgydRiyeJS08A8TPnbnEEmkJxVyg@mail.gmail.com>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
 <20130528173637.GE15794@arwen.pp.htv.fi>
 <CAGm1_ks7Y8n1xKA=qiCCFcxgydRiyeJS08A8TPnbnEEmkJxVyg@mail.gmail.com>
Message-ID: <20130529174144.GE21290@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 12:06:52PM +0200, Yegor Yefremov wrote:
> On Tue, May 28, 2013 at 7:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists at googlemail.com wrote:
> >> From: Yegor Yefremov <yegorslists@googlemail.com>
> >>
> >> 'ick' was changed to 'hsotgusb_ick'
> >> 'fck' was changed to 'hsotgusb_fck'
> >>
> >> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> >> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> >
> > NAK. Fix your clock data.
> 
> Do you mean here arch/arm/mach-omap2/cclock3xxx_data.c?

yes

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/e081ec5d/attachment.sig>
