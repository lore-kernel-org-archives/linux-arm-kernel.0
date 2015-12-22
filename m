From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Dec 2015 23:49:25 +0000
Subject: [RESEND PATCH v2 2/2] ASoC: atmel-classd: DT binding for PDMIC
 driver
In-Reply-To: <CAL_JsqKTNJ6Y0OUydkef3aYUO2jzDb30myvGJau-RBoJ3qe8hQ@mail.gmail.com>
References: <1450345800-21299-1-git-send-email-songjun.wu@atmel.com>
 <1450345800-21299-3-git-send-email-songjun.wu@atmel.com>
 <20151219040913.D0F442C02FD@rob-hp-laptop>
 <20151219113055.GF5727@sirena.org.uk>
 <CAL_JsqKTNJ6Y0OUydkef3aYUO2jzDb30myvGJau-RBoJ3qe8hQ@mail.gmail.com>
Message-ID: <20151222234925.GB16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 12:37:24PM -0600, Rob Herring wrote:
> On Sat, Dec 19, 2015 at 5:30 AM, Mark Brown <broonie@kernel.org> wrote:

> >> "label" can be used here if this is really needed.

> > The plastics for the system are often very important for audio
> > configuration - we need userspace to be able to distinguish between
> > systems that are identical even on the electrical level.

> Okay. That is exactly what label is for, so please use it.

Can you send fixes for this please?  There's rather a lot of existing
bindings using the current scheme, together with some subsystem code to
help parse them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/b6671fe3/attachment.sig>
