From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jul 2011 20:44:56 +0900
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using
	mc13783 codec
In-Reply-To: <4E1AD0DC.7020201@televic.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<20110709022501.GA26900@sirena.org.uk>
	<4E1AD0DC.7020201@televic.com>
Message-ID: <20110711114452.GK5092@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 12:30:52PM +0200, Lambrecht J?rgen wrote:

> But actually, I have my doubts. Is it possible to reuse such a platform 
> driver?
> I don't know the other platforms, maybe they differ a little bit?

Yes, of course.  Use platform data or key off something like
machine_is_() to handle small differences between systems in the same
way as for any other driver.  There's a few examples of this in the
tree.
