From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Mar 2014 10:13:38 +0000
Subject: [PATCH 00/18] edma/ASoC: dmaengine PCM for AM335x and AM447x
In-Reply-To: <5322CE32.2000102@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <20140313134601.GU366@sirena.org.uk> <5322CE32.2000102@ti.com>
Message-ID: <20140314101338.GP366@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 11:38:58AM +0200, Peter Ujfalusi wrote:

> The only thing I'm afraid off is that it is going to take two release cycle to
> get this in: first cycle edma part, next cycle for the ASoC to switch to use
> the edma-pcm.

We can do a cross tree merge, or the EDMA code can be applied to ASoC
directly if that's what people want.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140314/4fdb0760/attachment-0001.sig>
