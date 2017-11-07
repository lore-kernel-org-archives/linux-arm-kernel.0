From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Nov 2017 14:02:13 +0100
Subject: [PATCH 1/1] add mali r6p2 dt node
In-Reply-To: <1510059543-7064-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1510059543-7064-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20171107130213.g73f6oemzdkulgek@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 01:59:03PM +0100, Giulio Benetti wrote:
> It seems there is not mali node in sun7i-a20.dtsi
> 
> Add mali node to sun7i-a20.dtsi
> 
> This patch adds device tree mali node compatible with r6p2 utgard kernel driver 
> provided by ARM and patched by maxime ripard on his github.
> 
> It can be easily used in target.dts with:
> 
> &mali {
> 	status = "okay";
> }
> 
> then loading mali.ko in user space.

Can you please stop sending the same patch over and over again without
making any changes?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/69d494e8/attachment.sig>
