From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jun 2014 20:48:02 +0200
Subject: [PATCH 03/10] spi: sun4i: add DMA support
In-Reply-To: <1402890635-12342-4-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
 <1402890635-12342-4-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140625184802.GF19569@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 12:50:28AM -0300, Emilio L?pez wrote:
> This patch adds DMA support for 64 byte transfers on the sun4i SPI
> controller. Bigger transfers did not seem to work when tested, and if
> the hardware actually supports those, it will need further
> investigation as to how to issue them correctly.

Since you're only using DMA with 64+ bytes transfer, I'd say your DMA
transfers don't actually work :)

> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> This is a straight adaptation of a similar patch Maxime made for the
> sun6i SPI driver.

Which was not working either ;)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/cfa2f3f3/attachment-0001.sig>
