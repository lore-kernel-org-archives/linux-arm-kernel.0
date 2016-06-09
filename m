From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 18:23:10 +0200
Subject: [PATCH 2/2] ARM: dts: sun7i: HDMI and the tv-encoder use tcon
 ch1 not ch0
In-Reply-To: <1465129368-22335-2-git-send-email-hdegoede@redhat.com>
References: <1465129368-22335-1-git-send-email-hdegoede@redhat.com>
 <1465129368-22335-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160609162310.GD5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2016 at 02:22:48PM +0200, Hans de Goede wrote:
> Update the simplefb nodes for hdmi / tv-encoder out to point to
> tcon0_ch1 instead of tcon0_ch0 as tcon clock.
> 
> While at it fix the clocks lines being longer then 80 chars.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Fixed the typos (than vs then) and applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/99489607/attachment.sig>
