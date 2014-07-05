From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Jul 2014 21:50:24 -0700
Subject: [PATCH] ARM: sunxi: Reintroduce the restart code for A10/A20 SoCs
In-Reply-To: <1404049733-26226-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404049733-26226-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140705045024.GB5201@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 03:48:53PM +0200, Maxime Ripard wrote:
> This partly reverts commits 553600502b84 (ARM: sunxi: Remove reset code from
> the platform) and 5e669ec583e2 (ARM: sunxi: Remove init_machine callback) for
> the sun4i, sun5i and sun7i families.
> 
> This is needed because the watchdog counterpart of these commits was dropped,
> and didn't make it into 3.16. In order to still be able to reboot the board, we
> need to reintroduce that code. Of course, the long term view is still to get
> rid of that code in mach-sunxi.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Hi Arnd, Kevin, Olof,
> 
> Could you apply this patch directly and queue this as 3.16 fixes?

Applied (with 3 line offset).


-Olof
