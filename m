From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jun 2015 15:27:52 +0200
Subject: [PATCH v2 0/7] clk: sunxi: Add support for the Audio PLL
In-Reply-To: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150604132752.GM23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

On Thu, May 21, 2015 at 10:53:59PM +0200, Maxime Ripard wrote:
> Hi,
> 
> This serie adds support for the PLL2 aka the Audio PLL on the
> Allwinner A10 and the later SoCs.
> 
> This is the first stepping stone to get the audio support merged.
> 
> This serie is built on top of a generic clk-factor driver to handle
> clock that multiply their parent clock rate (mostly PLL's), in order
> to provide the driver for the PLL2 base clock, and then adds the
> drivers for the clock that derive from the Audio PLL.
> 
> Thanks!
> Maxime
> 

Any comments on that (especially the first patch)?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/b9d8f7be/attachment.sig>
