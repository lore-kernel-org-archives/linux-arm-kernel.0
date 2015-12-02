From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Dec 2015 10:45:43 +0000
Subject: [PATCH v4 2/3] ASoC: cygnus: Add Cygnus audio DAI driver
In-Reply-To: <565E54D2.50806@broadcom.com>
References: <1447114664-21799-1-git-send-email-ssimran@broadcom.com>
 <1447114664-21799-3-git-send-email-ssimran@broadcom.com>
 <20151122134440.GQ26072@sirena.org.uk>
 <565E54D2.50806@broadcom.com>
Message-ID: <20151202104543.GD1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 06:17:54PM -0800, Simran Rai wrote:
> On 11/22/2015 5:44 AM, Mark Brown wrote:

> >I would expect any initialisationn of clocks beyond the ones that the
> >device directly interacts with to be handled within the clock API
> >configuration rather than in a specific driver, this avoids the driver
> >being dependent on a particular system integration.

> I will have to figure out a way to propagate the frequency from leaf clocks to the parent
> clock. Will send out another patch with the fix.

The idea is that the clock API should take care of this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/70a271d5/attachment.sig>
