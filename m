From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Oct 2013 19:08:41 +0100
Subject: [RFC 00/15] Device Tree schemas and validation
In-Reply-To: <20131002135450.GH6506@voom.fritz.box>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com>
 <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
 <20131002135450.GH6506@voom.fritz.box>
Message-ID: <20131002180841.GG27287@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 11:54:50PM +1000, David Gibson wrote:
> On Tue, Oct 01, 2013 at 03:54:20PM -0500, Rob Herring wrote:

> > I would expect the schema to replace
> > Documentation/devicetree/bindings/* over time. I think the thing that
> > needs to be worked out here is how to add free form multi-line text.

> I'm not convinced that's a realistic goal.  As I see it, the
> fundamental difference between a binding document and a formal schema
> is that a binding defines both the syntax required of a node, and its
> semantics, whereas a schema defines only syntax - the semantics still
> need to be defined somewhere.

So long as the schema lets you include free form text to define the
semantics I'm not sure there's an incompatibility there - the same
document can cover both.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/af925648/attachment.sig>
