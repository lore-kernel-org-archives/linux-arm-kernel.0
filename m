From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 15:43:11 -0400
Subject: [patch] ARM: Kirkwood: fix Makefile.boot
In-Reply-To: <20120805203610.644315269@rtp-net.org>
References: <20120805203555.457907381@rtp-net.org>
 <20120805203610.644315269@rtp-net.org>
Message-ID: <20120814194311.GU22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 10:35:57PM +0200, Arnaud Patard wrote:
> While building the dtbs target, one is getting:
> 
> make dtbs
> make[1]: *** No rule to make target `arch/arm/boot/kirkwood-qnap-ts219.dtb', needed by `arch/arm/boot/dtbs'.  Stop.
> make: *** [dtbs] Error 2
> 
> The reason is that there's no kirkwood-qnap-ts219.dts file. Update Makefile.boot
> to reflect the dts files present.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

added Acked-By from Andrew Lunn and applied to:

git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6

thx,

Jason.
