From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Nov 2014 19:24:43 +0100
Subject: [PATCH 3/5] ARM: sunxi: Add "allwinner,sun6i-a31s" to mach-sunxi
In-Reply-To: <1416747283-13489-4-git-send-email-hdegoede@redhat.com>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
 <1416747283-13489-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20141125182443.GE25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 23, 2014 at 01:54:41PM +0100, Hans de Goede wrote:
> So fat the A31s is 100% compatible with the A31, still lets do the same
> as what we've done for the A13 / A10s and give it its own compatible string,
> in case need to differentiate later.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks a lot for this. It's been a long awaited addition.

I don't have any comment on this patch, except that you should also
update Documentation/arm/sunxi/README to reflect this newly supported
SoC.

That can go through another patch though.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/de81b3c5/attachment.sig>
