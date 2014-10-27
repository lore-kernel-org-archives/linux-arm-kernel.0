From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Oct 2014 17:26:36 +0000
Subject: [PATCH v1 02/10] dt-bindings: Document the standard property
 "system-power-controller"
In-Reply-To: <20141027163918.GB14253@saruman>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-2-git-send-email-romain.perier@gmail.com>
 <20141027163918.GB14253@saruman>
Message-ID: <20141027172636.GZ18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 11:39:18AM -0500, Felipe Balbi wrote:
> On Mon, Oct 27, 2014 at 04:26:47PM +0000, Romain Perier wrote:

> > +act8846: act8846 at 5 {
> > +	 compatible = "active-semi,act8846";
> > +	 status = "okay";
> > +	 system-power-controller;
> > +}

> there is no mention here that system-power-controller superseeds
> poweroff-source and deprecates that.

Given that poweroff-source hasn't made it into a released kernel yet we
can probably just kill it off completely can't we?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/fdc56111/attachment.sig>
