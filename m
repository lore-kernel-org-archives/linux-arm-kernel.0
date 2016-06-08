From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 8 Jun 2016 06:59:19 +0200
Subject: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
In-Reply-To: <CAMsMSK9X2ME=nyBhD4q8MvdYrqe7h+SmVstD++1OfBn-uvuSHA@mail.gmail.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
 <57409633.8060605@gmail.com> <20160603023853.GD8921@earth>
 <CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
 <20160607015017.GA25073@earth>
 <CAMsMSK9X2ME=nyBhD4q8MvdYrqe7h+SmVstD++1OfBn-uvuSHA@mail.gmail.com>
Message-ID: <20160608045919.GA28205@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 07, 2016 at 12:40:41PM -0700, Chris Brand wrote:
> On Mon, Jun 6, 2016 at 6:50 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Mon, Jun 06, 2016 at 09:42:03AM -0700, Chris Brand wrote:
> >> On Thu, Jun 2, 2016 at 7:38 PM, Sebastian Reichel <sre@kernel.org> wrote:
> >> > Feel free to queue it via arm-soc with
> >> >
> >> > Acked-By: Sebastian Reichel <sre@kernel.org>
> >> >
> >> > If I didn't overlook it, it's missing DT documentation, though.
> >>
> >> Thanks, Sebastian. Because this is effectively a move of code from
> >> arch/arm rather than new code, there's already dt documentation in
> >> Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt
> >
> > Ok. That directory is usually used for periphal reset controller.
> > Board/System reset controllers are usually documented in
> > .../bindings/power/reset (following kernel strucuture
> > [drivers/reset and drivers/power/reset]).
> >
> > -- Sebastian
> 
> Would you like me to send a separate patch to move that file ?

That would nice, thanks!

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160608/6c22f817/attachment.sig>
