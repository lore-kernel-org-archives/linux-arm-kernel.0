From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 12:49:29 +0000
Subject: [PATCH v6 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <20131204112039.GC907@lee--X1>
References: <1386153615-25456-1-git-send-email-k.kozlowski@samsung.com>
 <1386153615-25456-4-git-send-email-k.kozlowski@samsung.com>
 <20131204112039.GC907@lee--X1>
Message-ID: <20131204124929.GO29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 11:20:39AM +0000, Lee Jones wrote:

> > +		regulators {
> > +			compatible = "maxim,max14577-regulator";
> > +
> > +			safeout_reg: safeout at 1 {

> The name of the node (not the label:safeout_reg) usually depicts the
> type of device, so 'regulator at 0' and 'regulator at 1'. However, I'm
> unsure how this works when these nodes are encapsulated by an
> overarching 'regulators' parent node.

> Perhaps Mark can answer this?

The name there is meaningless, the DT convention is as you describe and
applies to any node but equally well it's just a convention and I
struggle to see the value it adds.  Having something that humans find
helpful is just as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/dbfbee7f/attachment-0001.sig>
