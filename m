From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Jun 2016 11:57:23 +0200
Subject: [PATCH V3] ARM: dts: sun7i: Add dts file for Bananapi M1 Plus
 board
In-Reply-To: <20160617095602.14612-1-luoyi.ly@gmail.com>
References: <20160617095602.14612-1-luoyi.ly@gmail.com>
Message-ID: <20160622095723.GU26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 17, 2016 at 05:56:02PM +0800, luoyi.ly at gmail.com wrote:
> From: Luo Yi <luoyi.ly@gmail.com>
> 
> Add support for the Bananapi M1 Plus A20 development board from
> sinovoip.com.cn . This board is nearly a clone of the Lemaker's
> Bananapro, but differ with the wlan chipset connection and i2s pinout.
> And I also enable the integrated audio codec on default.

This patch content is fine, but there's a lot of small issues:
  - You're not indenting the nodes properly
  - You're missing your Signed-off-by tag
  - And probably other stuff

This has all been reported by checkpatch.

Make sure you run checkpatch, make the modifications needed so that
you don't have any warnings or errors anymore, and resubmit it.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/c1e7f4c3/attachment.sig>
