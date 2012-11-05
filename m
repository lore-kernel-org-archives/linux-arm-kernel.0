From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 05 Nov 2012 17:19:33 +0000
Subject: vexpress issues in next-20121029
In-Reply-To: <201211051647.19785.arnd@arndb.de>
References: <508EE610.9050703@wwwdotorg.org>
 <20121105094511.GE28327@n2100.arm.linux.org.uk>
 <1352126598.10947.13.camel@hornet> <201211051647.19785.arnd@arndb.de>
Message-ID: <1352135973.10947.23.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-05 at 16:47 +0000, Arnd Bergmann wrote:
> I've just tried pulling in your branch again, but it appears unchanged:
> The patches are still based on 807e45b328, which is a different commit
> from bcd6f569e874 that is in Mike's tree. Please do as I asked you before
> and rebase on top of the commit that you sent him,

Ok, I think I got the idea now. Sorry about not catching up straight
away...

The following changes since commit bcd6f569e87471d7f104bd9497f0b516a3b12e32:

  clk: Common clocks implementation for Versatile Express (2012-10-29 11:08:03 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-clk-soc

for you to fetch changes up to 433683a66401adb0150792e725cc4f631c94de46:

  ARM: vexpress: Remove motherboard dependencies in the DTS files (2012-11-05 17:09:52 +0000)

>  and make sure that this is a commit that Mike never rebases.

Uh. Mike, is your clk-next subject to rebases?

Pawe?
