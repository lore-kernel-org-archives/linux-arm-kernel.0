From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Nov 2013 12:04:26 +0000
Subject: [PATCH 06/13] ASoC: ux500_pcm: Extend ux500 MSP binding for
 enumeration
In-Reply-To: <CACRpkdZgi9Egvm585Y9tJpmj0YX-oJBDg-C7pCu91Pf5ALMGLg@mail.gmail.com>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-7-git-send-email-lee.jones@linaro.org>
 <20131106104658.GE11602@sirena.org.uk>
 <CACRpkdZgi9Egvm585Y9tJpmj0YX-oJBDg-C7pCu91Pf5ALMGLg@mail.gmail.com>
Message-ID: <20131106120426.GL11602@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 12:55:51PM +0100, Linus Walleij wrote:
> On Wed, Nov 6, 2013 at 11:46 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Nov 06, 2013 at 10:16:18AM +0000, Lee Jones wrote:

> >> + - id               : MSP ID - used during component registration

> > I have no idea what this means or how one would pick the number?  It
> > looks like something purely internal to the driver...

> Actually it's quite common when we have several HW blocks of the
> same thing to add something like an id. For example for different
> GPIO banks.

That's common but having the number be in the device tree as a property
or referenced by anything like this isn't common - usually it's just in
the node name if it appears in the DT at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/758056c4/attachment.sig>
