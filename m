From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 16:04:48 +0200
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
In-Reply-To: <20160822121242.18827-1-pbrobinson@gmail.com>
References: <20160822121242.18827-1-pbrobinson@gmail.com>
Message-ID: <20160822140448.GP7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 22, 2016 at 01:12:42PM +0100, Peter Robinson wrote:
> Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
> these if the appropriate SoC they're embedded in isn't enabled.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/e8aa6d30/attachment.sig>
