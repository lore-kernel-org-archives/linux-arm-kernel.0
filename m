From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Apr 2018 12:09:08 +0100
Subject: [PATCH v4 10/14] dt-bindings: Add support for SAW documentation
In-Reply-To: <20180409202144.76gjmc6kcn2msffl@rob-hp-laptop>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-11-git-send-email-ilialin@codeaurora.org>
 <20180409202144.76gjmc6kcn2msffl@rob-hp-laptop>
Message-ID: <20180417110908.GE8973@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 03:21:44PM -0500, Rob Herring wrote:
> On Fri, Mar 30, 2018 at 12:26:43AM +0300, Ilia Lin wrote:
> > Add support for SAW controlled regulators in 8x96.
> > Document it.

> Perhaps some clue in the subject what subsystem and/or device this 
> applies to.

Right, especially given that if people can't find the documentation for
driver binding changes that's likely to be one of the first compliants.

> > +- qcom,saw-leader:
> > +	Usage: optional
> > +	Value type: <boo>
> > +	Description: SAW controlled gang leader. Will be configured as
> > +		     SAW regulator.

> Would the coupled regulator binding work in this case?

Someone would need to get the code working first though depending on
what the hardware does that might not be the right thing.  It's fairly
common to have hardware support for grouping multiple physical
regulators together into a single supply in order to provide more
current with all the control being done from one of the regulators.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/6156c958/attachment-0001.sig>
