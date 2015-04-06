From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 6 Apr 2015 19:38:15 +0200
Subject: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
In-Reply-To: <201504051552.10522@pali>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <201504051526.14575@pali> <20150405134528.GD9186@earth>
 <201504051552.10522@pali>
Message-ID: <20150406173815.GD18145@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Apr 05, 2015 at 03:52:10PM +0200, Pali Roh?r wrote:
> > So I suggest to enable the IBE bit in the kernel (that part is
> > already done) *and* in u-boot.
> > 
> > -- Sebastian
> 
> Yes. Code for both (U-Boot and linux kernel) exists and are 
> already included.
> 
> In linux kernel code is since 3.14-rc6 and in U-Boot code is 
> there since beginning of Nokia N900 support (2013.04) directly in 
> board code.

ah. I wasn't aware, that u-boot already sets the IBE bit on the N900.
Thanks for the information.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/969c7dea/attachment.sig>
