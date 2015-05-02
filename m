From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 2 May 2015 13:53:32 +0200
Subject: [linux-sunxi] ARM: sunxi: dts: split IR pins for A10 and A20
In-Reply-To: <1430566580-14295-1-git-send-email-codekipper@gmail.com>
References: <1430566580-14295-1-git-send-email-codekipper@gmail.com>
Message-ID: <20150502115332.GO6062@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 02, 2015 at 01:36:20PM +0200, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Currently none of the target boards nor the driver supports
> IR TX. However this pin is used in a few instances as a GPIO.
> Split the pin ctrl descriptions so that only the IR RX is
> configured to be used.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150502/b40d9bae/attachment-0001.sig>
