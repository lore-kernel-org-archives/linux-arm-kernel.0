From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 14:40:13 +0100
Subject: [PATCH 1/1] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <20120821125811.GA931@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
 <s5h628lu0q9.wl%tiwai@suse.de> <20120820113427.GN8450@gmail.com>
 <20120820143653.GE26991@opensource.wolfsonmicro.com>
 <20120821115123.GE26899@gmail.com>
 <20120821123951.GC7995@opensource.wolfsonmicro.com>
 <20120821125811.GA931@gmail.com>
Message-ID: <20120821134013.GG7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 01:58:12PM +0100, Lee Jones wrote:
> On Tue, Aug 21, 2012 at 01:39:51PM +0100, Mark Brown wrote:

> > The bit I quoted is the main example, you're including random mail
> > headers in the body of the mail.

> They're not mail headers per-say, they're `git format-patch` headers.
> I thought this was acceptable for single patches, hence why I've done
> it lots of times and had no complaints (until now).

> If there are some changes required in a single patch, I usually fix
> it up, create a patch with `git format-patch` and send it as a reply
> to either the original patch in the series or the mail containing the
> suggestion. If this is wrong please educate me as I thought this was

If you're going to do this send the patch properly in the same way
patches are normally sent.  Take a step back and think about this for a
minute - why would it be a good idea to send these incremental patches
in a different format which requires the person applying the patch to
hand edit things to strip out the noise?

> acceptable, as I thought it would be less pain than sending the
> entire patch-set again for just one change?

It makes it harder to work out which versions of things to apply and
causes issues for tools when doing things like applying from a mailbox.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/e65efd78/attachment.sig>
