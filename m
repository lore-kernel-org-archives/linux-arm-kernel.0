From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 18:19:24 +0100
Subject: [PATCH 2/7] ARM: dts: sun5i: Stop using different compatibles
 for ehci/ohci on a13 vs a10s
In-Reply-To: <1425754884-7875-2-git-send-email-hdegoede@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150308171924.GC5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 07, 2015 at 08:01:19PM +0100, Hans de Goede wrote:
> The A13 and the A10s use the same die (this has been confirmed by Allwinner),
> as such there is no need to differentiate between the ehci/ohci parts of both,
> the only reasons there were different allwinner,sun5i-a*-foo compatible
> between these 2 parts is costemetically and because we could when we still
> had 2 completely different dtsi files.
> 
> The allwinner,sun5i-a*-foo compatible strings are not used for binding at all,
> the actual driver binds to the generic-?hci compatible, so we can safely remove
> this cosmetical difference and simplify the dtsi files.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Appplied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/e2ce700d/attachment.sig>
