From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Feb 2017 08:52:43 +0100
Subject: [PATCH 0/4] ARM: sun7i: Convert sun7i SoC to sunxi-ng
In-Reply-To: <20170227210914.18954-1-plaes@plaes.org>
References: <20170227210914.18954-1-plaes@plaes.org>
Message-ID: <20170228075243.gschowjzagwuxgok@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On Mon, Feb 27, 2017 at 11:09:10PM +0200, Priit Laes wrote:
> Hi,
> 
> This is serie brings another SoC into the sunxi-ng world.
> 
> As mentioned in sun5i conversion, this is pretty much standard
> stuff as all the required clocks were already implemented in
> the sunxi-ng framework.

Thanks a lot for that work. I think the A10 should be converted at the
same time, and both would share the same driver.

Fortunately, if I recall properly, both are not too far off.

Thanks again,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170228/4185273b/attachment.sig>
