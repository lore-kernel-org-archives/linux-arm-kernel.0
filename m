From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 09:04:44 +0100
Subject: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
In-Reply-To: <20171203204157.20829-5-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
Message-ID: <20171205080444.zo2rlusqpjyraqcw@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 03, 2017 at 12:41:52PM -0800, Vasily Khoruzhick wrote:
> Digital part of audio codec block in the A64 is very similar to what
> is used by the A33(sun8i) devices. However, it uses different LRCK
> divider.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

What makes it impossible to derive from the sample rate and number of
channels?

Have you tried other sampling rates?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/f4ae3140/attachment.sig>
