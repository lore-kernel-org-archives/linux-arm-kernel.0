From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Sep 2015 14:29:34 +0200
Subject: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
In-Reply-To: <20150927165303.GI31209@lunn.ch>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl> <20150927165303.GI31209@lunn.ch>
Message-ID: <20150929122934.GQ7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 06:53:03PM +0200, Andrew Lunn wrote:
> > >+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
> > >+	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
> 
> Rather than have to extend this list every so often, how about adding
> a helper of_device_is_compatible_vendor(), so you can just have:

I don't know, I kind of like the fact that it's explicit. If we ever
have another SoC coming in with a different behaviour, we won't have
to expand it back.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150929/0e430dea/attachment.sig>
