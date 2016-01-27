From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Jan 2016 13:21:40 +0000
Subject: Problem with commit 924eb47512 ("ASoC: dwc: fix dma stop
 transferring issue")
In-Reply-To: <1453386247.2858.58.camel@linaro.org>
References: <1453386247.2858.58.camel@linaro.org>
Message-ID: <20160127132140.GN6042@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 02:24:07PM +0000, Jon Medhurst (Tixy) wrote:

> In trying to work out why audio stopped working on ARM's Juno board I
> bisected the problem to $subject commit and reverting this fixed things.

Yitian?  Tixy's analysis looks good, in the absence of further feedback
I intend to revert your change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/c4ca0747/attachment.sig>
