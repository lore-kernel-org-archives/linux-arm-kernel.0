From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Mar 2016 11:10:09 +0100
Subject: [PATCH 2/3] ARM: dts: sun5i-a13-empire-electronix-d709: Remove
 mmc2 node
In-Reply-To: <1457645884-10282-2-git-send-email-hdegoede@redhat.com>
References: <1457645884-10282-1-git-send-email-hdegoede@redhat.com>
 <1457645884-10282-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160311101009.GX8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:38:03PM +0100, Hans de Goede wrote:
> The empire-electronix-d709 does not have an emmc, it uses nand, the
> mmc2 node in the dts comes from a copy and paste error from the
> inet98fv2 dts, remove it.
> 
> While at it also do s/inet98fv2/d709/ to fix some other copy/paste
> leftovers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued for 4.7, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/4895e4f3/attachment.sig>
