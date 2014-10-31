From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Oct 2014 18:06:32 +0000
Subject: [PATCH v3 01/14] mfd: max77686/802: Map regulator driver to its
 own of_node
In-Reply-To: <1414760874.7318.15.camel@AMDC1943>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-2-git-send-email-k.kozlowski@samsung.com>
 <20141031122330.GP18557@sirena.org.uk>
 <1414760874.7318.15.camel@AMDC1943>
Message-ID: <20141031180632.GO18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 02:07:54PM +0100, Krzysztof Kozlowski wrote:
> On pi?, 2014-10-31 at 12:23 +0000, Mark Brown wrote:

> > I'm getting very frustrated with what's going on with these drivers,
> > there seem to be a lot of rather large sets of patches spawning lots of
> > discussion but also frequent review problems and very little actually
> > getting merged (look at the set of changes in the past few merge windows
> > for example).  There's something going wrong here.

> If I over-spammed you, then I am deeply sorry.

It's not just about volume, it's also about the fact that so little of
the mail around these drivers (not just from you) is translating into
code that gets merged.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/a9c7c111/attachment.sig>
