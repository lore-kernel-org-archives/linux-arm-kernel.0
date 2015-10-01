From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 22:33:31 +0200
Subject: [PATCH v2 resend 0/4] ARM: dts: sunxi: q8 A13 tablet backlight
 support
In-Reply-To: <1443522591-6590-1-git-send-email-hdegoede@redhat.com>
References: <1443522591-6590-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151001203331.GP7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 29, 2015 at 12:29:47PM +0200, Hans de Goede wrote:
> Hi Maxime,
> 
> This series seems to have fallen through the cracks, hence this
> resend.

No, it didn't fall through the cracks, I asked a question on the first
patch and never got a reply.

The way we handled *all* the controllers so far is that the compatible
was representing what the controllers what features the controller was
exposing. This is the case for the clocks or pinctrl for example.

We should be consistent with that (beside the fact that using a
compatible from a later SoC is wrong).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/cbee7732/attachment.sig>
