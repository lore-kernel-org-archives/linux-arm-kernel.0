From: broonie@kernel.org (Mark Brown)
Date: Sat, 19 Dec 2015 11:30:55 +0000
Subject: [RESEND PATCH v2 2/2] ASoC: atmel-classd: DT binding for PDMIC
 driver
In-Reply-To: <20151219040913.D0F442C02FD@rob-hp-laptop>
References: <1450345800-21299-1-git-send-email-songjun.wu@atmel.com>
 <1450345800-21299-3-git-send-email-songjun.wu@atmel.com>
 <20151219040913.D0F442C02FD@rob-hp-laptop>
Message-ID: <20151219113055.GF5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 01:56:21PM -0600, Rob Herring wrote:
> On Thu, Dec 17, 2015 at 05:50:00PM +0800, Songjun Wu wrote:

> > +- atmel,model
> > +	The user-visible name of this sound card.
> > +	The default value is "PDMIC".

> When and why would this be different than the default?

> "label" can be used here if this is really needed.

The plastics for the system are often very important for audio
configuration - we need userspace to be able to distinguish between
systems that are identical even on the electrical level.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151219/0ab432ed/attachment.sig>
