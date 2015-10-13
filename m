From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Oct 2015 20:41:42 +0200
Subject: [PATCH 3/3] ARM: dts: sun8i: Make et-q8-v1.6.dts a symlink to
 q8-tablet.dts
In-Reply-To: <1444739748-26422-3-git-send-email-hdegoede@redhat.com>
References: <1444739748-26422-1-git-send-email-hdegoede@redhat.com>
 <1444739748-26422-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20151013184142.GN2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 02:35:48PM +0200, Hans de Goede wrote:
> A33 Q8 tablets with the et-q8-v1.6 pcb will work fine with the
> generic q8-tablet.dts and given the many variants of PCBs found in
> Q8 tablets using such a specific dts name was a mistake in hindsight.
> 
> We cannot just drop the et-q8-v1.6.dtb as existing u-boot configs
> may very well point to it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/44f751a8/attachment.sig>
