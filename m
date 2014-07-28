From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Mon, 28 Jul 2014 14:28:12 +0200
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <20140728122042.GR17528@sirena.org.uk>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-10-git-send-email-afaerber@suse.de>
 <53D20A61.1050506@metafoo.de> <53D21066.8000905@monstr.eu>
 <20140725101815.GO17528@sirena.org.uk> <53D2324B.4070602@suse.de>
 <20140725103905.GP17528@sirena.org.uk> <53D63746.3000905@suse.de>
 <20140728122042.GR17528@sirena.org.uk>
Message-ID: <53D641DC.4020804@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.07.2014 14:20, schrieb Mark Brown:
> On Mon, Jul 28, 2014 at 01:43:02PM +0200, Andreas F?rber wrote:
>> Am 25.07.2014 12:39, schrieb Mark Brown:
>>> On Fri, Jul 25, 2014 at 12:32:43PM +0200, Andreas F?rber wrote:
> 
>>>> Maybe this works for you?
>>>> https://patchwork.kernel.org/patch/4620191/
> 
>>>> Otherwise I can resend with Ab/Rb.
> 
>>> Documentation/SubmittingPatches.
> 
>> Not helpful here, nor is
>> Documentation/devicetree/bindings/submitting-patches.txt. It's separate
>> from code changes, sent via git-send-email, has a Sob, went to LKML and
>> LAKML and DTML. I could add a Fixes: header and CC trivial for this
>> one-line fix IIUC.
> 
> It's telling you that the kernel process is to review patches sent via
> e-mail, not random links to web appliations - notice the context to
> which I'm replying, I'm saying that sending a link to something on the
> web isn't a good way of submitting a patch.
> 
>> Doesn't tell me which patches I should CC you on in the future though.
>> Therefore my request to fix the false negative in MAINTAINERS so that me
>> and other kernel newbies don't run into it again.
> 
> Feel free to submit patches if you want to see changes.

Dude, this patch *was* submitted and has been reviewed by two people.
Don't pretend I didn't follow the SubmittingPatches workflow.

The link I gave you contains an mbox-format link that can be used with
wget and git-am to *apply* the patch if you apparently missed it on the
mailing lists.

I will *re*-submit it for your convenience.

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/ff5dcc7a/attachment.sig>
