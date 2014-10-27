From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Oct 2014 17:57:25 +0000
Subject: [PATCH v1 02/10] dt-bindings: Document the standard property
 "system-power-controller"
In-Reply-To: <20141027173025.GA16005@saruman>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-2-git-send-email-romain.perier@gmail.com>
 <20141027163918.GB14253@saruman>
 <20141027172636.GZ18557@sirena.org.uk>
 <20141027173025.GA16005@saruman>
Message-ID: <20141027175725.GB18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 12:30:25PM -0500, Felipe Balbi wrote:
> On Mon, Oct 27, 2014 at 05:26:36PM +0000, Mark Brown wrote:

> > Given that poweroff-source hasn't made it into a released kernel yet we
> > can probably just kill it off completely can't we?

> please do, then we will never have that commit in Linus' tree to give us
> nightmares.

Well, the commit isn't a particularly big deal (and got cross-merged
into another tree already) - if it's convenient to rebase it out we
probably should but it's also not the end of the world either so long as
it doesn't appear in a release.  Worst case people adopt it based on the
list discussions and we check for two properties which also isn't that
bad.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/7034db18/attachment.sig>
