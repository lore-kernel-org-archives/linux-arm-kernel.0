From: david@gibson.dropbear.id.au (David Gibson)
Date: Thu, 3 Oct 2013 09:38:59 +1000
Subject: [RFC 00/15] Device Tree schemas and validation
In-Reply-To: <20131002180841.GG27287@sirena.org.uk>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com>
 <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
 <20131002135450.GH6506@voom.fritz.box>
 <20131002180841.GG27287@sirena.org.uk>
Message-ID: <20131002233859.GB29875@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 07:08:41PM +0100, Mark Brown wrote:
> On Wed, Oct 02, 2013 at 11:54:50PM +1000, David Gibson wrote:
> > On Tue, Oct 01, 2013 at 03:54:20PM -0500, Rob Herring wrote:
> 
> > > I would expect the schema to replace
> > > Documentation/devicetree/bindings/* over time. I think the thing that
> > > needs to be worked out here is how to add free form multi-line text.
> 
> > I'm not convinced that's a realistic goal.  As I see it, the
> > fundamental difference between a binding document and a formal schema
> > is that a binding defines both the syntax required of a node, and its
> > semantics, whereas a schema defines only syntax - the semantics still
> > need to be defined somewhere.
> 
> So long as the schema lets you include free form text to define the
> semantics I'm not sure there's an incompatibility there - the same
> document can cover both.

True, there's no reason the machine-readable schema and human-readable
documentation can't be contained in the same file.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131003/583920cd/attachment.sig>
