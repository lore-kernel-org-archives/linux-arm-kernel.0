From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Wed, 2 May 2012 13:32:44 +0000
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120502015650.GE17311@gmail.com>
References: <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
 <20120501181922.GD4089@opensource.wolfsonmicro.com>
 <20120502015650.GE17311@gmail.com>
Message-ID: <201205021332.44699.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2012, Mike Turquette wrote:
> I was happy to push my changes to Linus directly (as discussed in
> previous mails) but I'm starting to think that maybe having Arnd absorb
> the clk-next branch as part of arm-soc would be the fastest way to
> assist platforms that are porting over.
> 
> Do the platform folks agree?  Is this suggestion sane?

I guess that makes sense while there are still nontrivial
interdependencies between work going the clk-next branch and into
arm-soc.

	Arnd
