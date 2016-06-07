From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 7 Jun 2016 03:50:17 +0200
Subject: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
In-Reply-To: <CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
 <57409633.8060605@gmail.com> <20160603023853.GD8921@earth>
 <CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
Message-ID: <20160607015017.GA25073@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 06, 2016 at 09:42:03AM -0700, Chris Brand wrote:
> On Thu, Jun 2, 2016 at 7:38 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Feel free to queue it via arm-soc with
> >
> > Acked-By: Sebastian Reichel <sre@kernel.org>
> >
> > If I didn't overlook it, it's missing DT documentation, though.
> 
> Thanks, Sebastian. Because this is effectively a move of code from
> arch/arm rather than new code, there's already dt documentation in
> Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt

Ok. That directory is usually used for periphal reset controller.
Board/System reset controllers are usually documented in
.../bindings/power/reset (following kernel strucuture
[drivers/reset and drivers/power/reset]).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/c9f3bfd4/attachment-0001.sig>
