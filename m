From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 17 Aug 2015 14:11:43 +0200
Subject: [PATCH] drm: panel: simple: add QiaoDian qd43003c0-40
In-Reply-To: <20150817105724.GT22269@piout.net>
References: <1438382671-10098-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150817100913.GA8453@ulmo.nvidia.com>
 <20150817105724.GT22269@piout.net>
Message-ID: <20150817121142.GK8453@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 12:57:24PM +0200, Alexandre Belloni wrote:
> On 17/08/2015 at 12:09:14 +0200, Thierry Reding wrote :
> > On Sat, Aug 01, 2015 at 12:44:31AM +0200, Alexandre Belloni wrote:
> > > From: Josh Wu <josh.wu@atmel.com>
> > > 
> > > The QiaoDian Xianshi QD43003C0-40 is a 4"3 TFT LCD panel.
> > > 
> > > Timings from the OTA5180A document, ver 0.9, section
> > > 10.1.1:
> > >   http://www.orientdisplay.com/pdf/OTA5180A.pdf
> > > 
> > > Signed-off-by: Josh Wu <josh.wu@atmel.com>
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/panel/qd,qd43003c0-40.txt  |  7 ++++++
> > >  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/panel/qd,qd43003c0-40.txt
> > 
> > You didn't run this through scripts/get_maintainer.pl, did you? It would
> > also help to use the standard prefix ("drm/panel: ") because I end up
> > filtering for that occasionally in case somebody didn't Cc me on panel
> > patches.
> > 
> 
> I'm pretty sure I did as you were the only one in the To: field.
> Maybe you want to check your spam filter.

Looking again, I see that you did indeed. Not sure what I was looking at
before. I apologize.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150817/4cd45f43/attachment.sig>
