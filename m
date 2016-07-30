From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Jul 2016 17:16:19 +0200
Subject: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
In-Reply-To: <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20160730151619.GR6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 04:25:48PM +0200, Hans de Goede wrote:
> Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
> and newer.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This should probably go through Ulf tree together with the rest of
that serie to maintain the bisectability.

Thanks a lot for this work,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/90437885/attachment.sig>
