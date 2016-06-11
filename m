From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 11 Jun 2016 16:29:50 +0200
Subject: [PATCH 0/6] ARM: dts: sunxi: Enable otg support on a23/a33 boards
In-Reply-To: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
References: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160611142950.GB19854@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 11, 2016 at 03:53:00PM +0200, Hans de Goede wrote:
> Hi All,
> 
> All the necessary bits for this have been merged in the various foo-next
> tree-s, so lets merge the dts bits and enable full otg support on these
> boards.
> 
> Note that we cannot yet do this for a31 based boards as the axp221 pmic
> has a quirk where it will not generate interrupts for vbus state changes
> when it itself is driving vbus. I've a patch to work around this, but
> this patch is part of a larger set which still needs to be merged.

Applied all of them, thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160611/f46f80f2/attachment.sig>
