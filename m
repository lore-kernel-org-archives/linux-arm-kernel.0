From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Oct 2012 23:16:07 +0100
Subject: [PATCH] MMC: fix sdhci-dove removal
In-Reply-To: <87vcdtosnx.fsf@octavius.laptop.org>
References: <20121015094348.GP21164@n2100.arm.linux.org.uk>
 <20121015103725.GQ21164@n2100.arm.linux.org.uk>
 <20121015104456.GR21164@n2100.arm.linux.org.uk>
 <87txtdq90y.fsf@octavius.laptop.org>
 <20121029214307.GH21164@n2100.arm.linux.org.uk>
 <87vcdtosnx.fsf@octavius.laptop.org>
Message-ID: <508F0027.1010102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2012 10:49 PM, Chris Ball wrote:
> On Mon, Oct 29 2012, Russell King - ARM Linux wrote:
>> Anyway, here's a replacement patch, updated against my cubox tree but
>> lacking the cubox gpio changes for it.  Un-tested through: (a) I can't
>> test this on its own on the cubox, (b) I don't have a separate dove
>> tree to test it against and my disk space is all but out at the moment
>> for yet another build tree...
>
> Compile-tested and pushed to mmc-next, and I'll submit it for 3.7 if
> I get a Tested-by from someone like Sebastian (CC'd), or for 3.8 if I
> don't.  (I'll add sdhci-pltfm API rework to my TODO list, too.)

Chris, Russell,

obviously I am not the one to ask for a Tested-by because it was my
patch that originally caused all the trouble. My apologies for this!

Anyway, I did test the patch on 3.7-rc3 and except that you need a
3-way git am because of a one-line offset, sdhci-dove runs just fine.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
