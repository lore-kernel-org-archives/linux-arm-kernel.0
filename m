From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Mar 2016 08:59:04 +0100
Subject: [PATCH] ARM: dts: sun8i: Base Orange Pi Plus dts on the Orange
 Pi 2 dts
In-Reply-To: <1458771256-4069-1-git-send-email-hdegoede@redhat.com>
References: <1458771256-4069-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160324075904.GU30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 23, 2016 at 11:14:16PM +0100, Hans de Goede wrote:
> The Orange Pi Plus really is an Orange Pi 2 extended with:
> 1) A sata <-> usb bridge connected to ehci3
> 2) An eMMC on mmc2
> 3) An external gigabit ethernet phy instead of the integrated 100Mbit phy
> 
> This commit changes the dts to reflect this by making it include
> the Orange Pi 2 dts and then adding the extra bits.
> 
> Note that the difference in ethernet phy is not taken into account
> because we do not have an ethernet driver for the H3 yet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Unfortunately, the patch doesn't apply anymore, and the merge doesn't
seem trivial.

I pushed my branch on my kernel.org repo, can you rebase your patch on
top and resend it?

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/34885a25/attachment.sig>
