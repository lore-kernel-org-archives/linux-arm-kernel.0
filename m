From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Jul 2014 13:20:42 +0100
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <53D63746.3000905@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-10-git-send-email-afaerber@suse.de>
 <53D20A61.1050506@metafoo.de> <53D21066.8000905@monstr.eu>
 <20140725101815.GO17528@sirena.org.uk> <53D2324B.4070602@suse.de>
 <20140725103905.GP17528@sirena.org.uk> <53D63746.3000905@suse.de>
Message-ID: <20140728122042.GR17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 01:43:02PM +0200, Andreas F?rber wrote:
> Am 25.07.2014 12:39, schrieb Mark Brown:
> > On Fri, Jul 25, 2014 at 12:32:43PM +0200, Andreas F?rber wrote:

> >> Maybe this works for you?
> >> https://patchwork.kernel.org/patch/4620191/

> >> Otherwise I can resend with Ab/Rb.

> > Documentation/SubmittingPatches.

> Not helpful here, nor is
> Documentation/devicetree/bindings/submitting-patches.txt. It's separate
> from code changes, sent via git-send-email, has a Sob, went to LKML and
> LAKML and DTML. I could add a Fixes: header and CC trivial for this
> one-line fix IIUC.

It's telling you that the kernel process is to review patches sent via
e-mail, not random links to web appliations - notice the context to
which I'm replying, I'm saying that sending a link to something on the
web isn't a good way of submitting a patch.

> Doesn't tell me which patches I should CC you on in the future though.
> Therefore my request to fix the false negative in MAINTAINERS so that me
> and other kernel newbies don't run into it again.

Feel free to submit patches if you want to see changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/fe57ca1d/attachment.sig>
