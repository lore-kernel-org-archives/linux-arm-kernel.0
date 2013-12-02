From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Dec 2013 13:23:33 +0000
Subject: [PATCH] ARM:INTEGRATOR: Default enable ARM_PATCH_PHYS_VIRT,
 AUTO_ZRELADDR
In-Reply-To: <CACRpkdZv9cZekBfJ2P1G4pMYOyAobmA2mszF=kN0Db5TC6_5+Q@mail.gmail.com>
References: <1385983731-13196-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
 <1385983731-13196-2-git-send-email-panchaxari.prasannamurthy@linaro.org>
 <20131202114638.GH16735@n2100.arm.linux.org.uk>
 <CACRpkdZv9cZekBfJ2P1G4pMYOyAobmA2mszF=kN0Db5TC6_5+Q@mail.gmail.com>
Message-ID: <20131202132333.GJ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 01:57:10PM +0100, Linus Walleij wrote:
> Good point, I've also seen "[RFT]" (request for testing) in some
> cases.

Note that it still needs [PATCH] before it.  A good way to integrate it
is to use the form "[PATCH CFT n/nn]" where n/nn exists if you have a
series.
