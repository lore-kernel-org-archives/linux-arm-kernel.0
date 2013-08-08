From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 14:20:00 +0100
Subject: [PATCH 13/20] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <5203676F.6090708@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-14-git-send-email-zonque@gmail.com>
 <20130807164039.GM6427@sirena.org.uk> <5203676F.6090708@gmail.com>
Message-ID: <20130808132000.GD6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:39:59AM +0200, Daniel Mack wrote:

> Then, we should also allocate the DMA channel from the upstream device
> and pass it down to the DAI. But then again, the pxa-pcm-lib needs some
> rework, as it's currently in charge of obtaining and releasing the channel.

> I wanted to postpone that issue until the rest of the series has settled
> and limit changes to the bare minimum for now. Does that sound feasible?

Yup, the big problem here is the whole DT as ABI thing - what happens in
the code isn't so important but the DT is supposed to be stable.  Or we
could decide that this is one of the cases that's unstable in which case
we should probably flag it up in the DT binding document if nothing else.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/3b7a01cb/attachment.sig>
