From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 25 Sep 2012 21:05:28 +0100
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <1348603151.5565.20@snotra>
References: <20120925195127.GA19350@sirena.org.uk> <1348603151.5565.20@snotra>
Message-ID: <20120925200528.GK4428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 02:59:11PM -0500, Scott Wood wrote:
> On 09/25/2012 02:51:27 PM, Mark Brown wrote:

> >The constant example is the magic numbers we need to embed into
> >DTs for
> >things like interrupt modes, making them human readable would be a
> >real
> >win.

> Wasn't there a patch for named constant support in dtc a while back?
> Hmm: https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-January/011184.html

> I'm not sure that going down the CPP path is better than the
> possibility of named constants having a different syntax from
> macros/functions.  It would be one thing if someone were actively
> working on the latter, but this paralysis seems to be a case of the
> perfect being the enemy of the good.

I don't know, it doesn't appear to have been integrated (and we still
need to be able to or things together).
