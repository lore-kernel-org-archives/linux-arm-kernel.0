From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Aug 2015 17:17:54 +0200
Subject: [PATCH 2/3] ARM: dts: sun6i: Turn on gmac on Colombus
In-Reply-To: <1438960955-6551-2-git-send-email-hdegoede@redhat.com>
References: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
 <1438960955-6551-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150819151754.GH30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 05:22:34PM +0200, Hans de Goede wrote:
> We've everything we need to support the gmac on Colombus, turn it on.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I recall that the phy was powered by one of the AXP221 regulators,
does it require some additional stuff (like a recent u-boot), or does
it just work and my memory is bad :) ?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/03e65392/attachment.sig>
