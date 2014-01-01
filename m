From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Jan 2014 23:58:46 +0100
Subject: [PATCHv2 1/1] ARM: sunxi: select ARM_PSCI
In-Reply-To: <1388595775-20737-1-git-send-email-zalan.blenessy@gmail.com>
References: <1387973466-5067-1-git-send-email-zalan.blenessy@gmail.com>
 <1388595775-20737-1-git-send-email-zalan.blenessy@gmail.com>
Message-ID: <20140101225846.GC3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zalan,

On Wed, Jan 01, 2014 at 06:02:55PM +0100, Zalan Blenessy wrote:
> On Allwinner sun7i (A20) SoCs, the SMP operations are implemented in 
> u-boot, and exposed to the kernel through PSCI. 
> 
> We thus need to enable PSCI support for Allwinner SoCs so that the 
> kernel uses it to bring up the additionnal cores.
> 
> Signed-off-by: Signed-off-by: Zalan Blenessy <zalan.blenessy@gmail.com>

Thanks!

Applied in sunxi/core-for-3.14.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140101/addfb7ba/attachment.sig>
