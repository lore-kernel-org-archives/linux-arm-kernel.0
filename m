From: balbi@ti.com (Felipe Balbi)
Date: Thu, 30 May 2013 22:06:21 +0300
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <20130530081211.GA1915@gmail.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
 <20130529175741.GG21290@arwen.pp.htv.fi>
 <CACRpkda3d9_XvqRmy0nbWyri2xC3Qst2U2Sv=UDxV4w-UxK_JQ@mail.gmail.com>
 <20130530081211.GA1915@gmail.com>
Message-ID: <20130530190621.GB6277@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI

On Thu, May 30, 2013 at 09:12:11AM +0100, Lee Jones wrote:
> On Thu, 30 May 2013, Linus Walleij wrote:
> 
> > On Wed, May 29, 2013 at 7:57 PM, Felipe Balbi <balbi@ti.com> wrote:
> > > On Wed, May 15, 2013 at 10:51:43AM +0100, Lee Jones wrote:
> > >> For all ux500 based platforms the maximum number of end-points are used.
> > >> Move this knowledge into the driver so we can relinquish the burden from
> > >> platform data. This also removes quite a bit of complexity from the driver
> > >> and will aid us when we come to enable the driver for Device Tree.
> > >>
> > >> Cc: Felipe Balbi <balbi@ti.com>
> > >> Cc: linux-usb at vger.kernel.org
> > >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > >> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > >
> > > for drivers/usb/musb
> > >
> > > Acked-by: Felipe Balbi <balbi@ti.com>
> > 
> > Is that only for this patch 20/39 or also 21, 22 & 23?
> > 
> > Poke us if we should re-send them...
> 
> I read this as all patches in the series "for drivers/usb/musb".

right :-) Should've sent on patch 0/39, my bad.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130530/e68b3510/attachment.sig>
