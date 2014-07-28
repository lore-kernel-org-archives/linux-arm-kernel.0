From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Mon, 28 Jul 2014 13:43:02 +0200
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <20140725103905.GP17528@sirena.org.uk>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-10-git-send-email-afaerber@suse.de>
 <53D20A61.1050506@metafoo.de> <53D21066.8000905@monstr.eu>
 <20140725101815.GO17528@sirena.org.uk> <53D2324B.4070602@suse.de>
 <20140725103905.GP17528@sirena.org.uk>
Message-ID: <53D63746.3000905@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

Am 25.07.2014 12:39, schrieb Mark Brown:
> On Fri, Jul 25, 2014 at 12:32:43PM +0200, Andreas F?rber wrote:
> 
>> I used scripts/get_maintainer.pl --nogit-fallback. If you were not
>> CC'ed and need to be, please submit a MAINTAINERS patch. :)
> 
> You need to think about what you're doing when you use get_maintainer,
> it gives both false positives and false negatives.
> 
>> Maybe this works for you?
>> https://patchwork.kernel.org/patch/4620191/
> 
>> Otherwise I can resend with Ab/Rb.
> 
> Documentation/SubmittingPatches.

Not helpful here, nor is
Documentation/devicetree/bindings/submitting-patches.txt. It's separate
from code changes, sent via git-send-email, has a Sob, went to LKML and
LAKML and DTML. I could add a Fixes: header and CC trivial for this
one-line fix IIUC.
Doesn't tell me which patches I should CC you on in the future though.
Therefore my request to fix the false negative in MAINTAINERS so that me
and other kernel newbies don't run into it again.

I'll simply interpret your reply as "yes, please resend with
broonie at kernel.org CC'ed" then.

Regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/844b92cc/attachment.sig>
