From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 21 Jan 2013 21:36:10 +0100
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <20130121171022.GC10020@beef> (Matt Porter's message of "Mon, 21
 Jan 2013 12:10:22 -0500")
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <49ca66a84bb245ca9cfe4fd044c4d6f6@DFLE72.ent.ti.com>
 <20130121171022.GC10020@beef>
Message-ID: <87fw1u9sud.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Matt" == Matt Porter <mporter@ti.com> writes:

 Matt> On Mon, Jan 21, 2013 at 04:32:13PM +0000, Mark Jackson wrote:

 >> Does anyone know when the BeagleBone support is going to be fixed in
 >> mainline ?

 Matt> Hi Mark,

 Matt> I'm not sure what needs to be fixed. The only thing my edma dmaengine
 Matt> series adds is new features (specifically, mmc and spi dma support).
 Matt> I would suspect some boot problem specific to Paul's configuration
 Matt> if it's hanging. I just booted current mainline with an
 Matt> omap2plus_defconfig build on my bone a5 and it came up fine.

It also works here. I have noticed issues with nfs boot and recent
mainline when powered from the USB cable though. I suspect we're getting
close to the power limit.

-- 
Bye, Peter Korsgaard
