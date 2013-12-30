From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Dec 2013 16:31:54 +0100
Subject: [PATCH 1/1] ARM: sunxi: select ARM_PSCI
In-Reply-To: <1387973466-5067-2-git-send-email-zalan.blenessy@gmail.com>
References: <1387973466-5067-1-git-send-email-zalan.blenessy@gmail.com>
 <1387973466-5067-2-git-send-email-zalan.blenessy@gmail.com>
Message-ID: <20131230153154.GV3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zalan,

On Wed, Dec 25, 2013 at 01:11:06PM +0100, Zalan Blenessy wrote:
> This is necessary for SMP on sun7i.
> 
> Signed-off-by: Zalan Blenessy <zalan.blenessy@gmail.com>

I'd expect a bit more details here. What you wrote in your cover
letter would be a good start.

Something like 
----8<----
On Allwinner sun7i (A20) SoCs, the SMP operations are implemented in
u-boot, and exposed to the kernel through PSCI.

We thus need to enable PSCI support for Allwinner SoCs so that the
kernel uses it to bring up the additionnal cores.
----8<----

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/ce400d0b/attachment.sig>
