From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Jul 2014 14:22:27 +0200
Subject: [PATCH v2 2/8] spi: sun4i: add DMA support
In-Reply-To: <1404619518-7592-3-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140710122227.GC27469@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Sun, Jul 06, 2014 at 01:05:09AM -0300, Emilio L?pez wrote:
> This patch adds DMA support for 64 byte transfers on the sun4i SPI
> controller. Bigger transfers did not seem to work when tested, and if
> the hardware actually supports those, it will need further
> investigation as to how to issue them correctly.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

This patch looks fine from a quick look, but you should put Mark Brown
in the recipients, since he's the SPI maintainer, and will probably
have a sharper look.

Thanks!
Maxim

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/58b7adb0/attachment-0001.sig>
