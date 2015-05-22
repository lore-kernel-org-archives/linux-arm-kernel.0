From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 May 2015 17:33:27 +0100
Subject: [PATCH] coresight: etb: Remove simple announcement message
In-Reply-To: <CANLsYkyW44THumc5ebWnX-sa5zG7X0dv1_UEqUp9Av8c5PDegg@mail.gmail.com>
References: <1432122101-2233-1-git-send-email-broonie@kernel.org>
 <CANLsYkyW44THumc5ebWnX-sa5zG7X0dv1_UEqUp9Av8c5PDegg@mail.gmail.com>
Message-ID: <20150522163327.GU21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 08:17:21AM -0600, Mathieu Poirier wrote:

> Linus Walleij started doing something interesting with the initial
> printouts [1] and I think this is a better option than not printing
> anything at all.

It's definitely better to print information we enumerate from hardware,
though I'm not 100% sure if AMBA does the right thing with matching here
(most of the buses ignore hardware IDs in favour of DT information if
things are bound via DT).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/08d720aa/attachment.sig>
