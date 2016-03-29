From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Mar 2016 14:03:40 +0200
Subject: [linux-sunxi] [PATCH 1/3] sunxi: A20-OLinuXino-LIME2: Fix
 ldo3/ldo4 in DTS
In-Reply-To: <56F92B27.5050009@redhat.com>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <56F5DEB9.7070207@gmail.com> <56F64ED5.7030405@gmail.com>
 <56F794E1.4080108@computerlinguist.org>
 <56F92B27.5050009@redhat.com>
Message-ID: <20160329120340.GM30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 03:01:27PM +0200, Hans de Goede wrote:
> >but unless there's a real need
> >for me to verify this,
> >I'll simply revert the u-boot patch and enjoy working GPIO.
> 
> Given the entire discussion in this thread, I agree that fixing this in u-boot
> is best. But I do not see reverting the u-boot patch disabling ldo3/4 by default
> as the solution. ldo3/4 are unused on most boards, so disabling them by default
> clearly is the right thing todo IMHO.
> 
> Instead please submit a patch for configs/A20-OLinuXino-Lime2_defconfig which
> configures them at 2800 mV there (per the Lime2 schematic).
> 
> It would be good to also check the Lime1 schematic if they are used in the same
> way there, I would also welcome a patch for:
> 
> configs/A10-OLinuXino-Lime_defconfig
> configs/A20-OLinuXino-Lime_defconfig

Adding a comment to the DT summing up that whole discussion would be
great too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/ecb1c060/attachment.sig>
