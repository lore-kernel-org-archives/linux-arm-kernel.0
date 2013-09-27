From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Sep 2013 10:55:15 +0100
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
References: <20130919105437.75e0f0a3@armhf> <5240B07C.6080404@wwwdotorg.org>
 <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
Message-ID: <20130927095515.GZ19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 09:57:30PM -0500, Rob Herring wrote:
> On Mon, Sep 23, 2013 at 4:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> > We shouldn't have any Linux-specific bindings. It might be reasonable to
> > define a binding for a "simple CODEC", but there's no reason it should
> > be Linux-specific.

> Further, just define the type of codec h/w. If linux can use its
> simple-codec driver for it, then add a match table entry for said
> codec. Then the DT is future proof when you decide the simple driver
> doesn't really work for that h/w.

So, this is what I keep telling people to do but lots of people don't
want to do this - it eliminates the need have this binding at all since
if you know which type of device you have there's no need to specify
fixed properties of the device via DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/eb239154/attachment.sig>
