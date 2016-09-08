From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 22:09:08 +0200
Subject: [PATCH v3 0/8] clk: sunxi-ng: Introduce support for A23 and A33
 CCUs
In-Reply-To: <20160908094843.14710-1-maxime.ripard@free-electrons.com>
References: <20160908094843.14710-1-maxime.ripard@free-electrons.com>
Message-ID: <20160908200908.GS8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 11:48:35AM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> Here is the migration for the A23 and A33 clocks to the sunxi-ng
> framework.
> 
> It has been tested on SinA33 board, and I made sure that everything
> was reported at the exact same rate, that the MMC was still working in
> DDR, etc.
> 
> This has also been tested to implement the DRM driver, so I'm
> confident things will work just fine.
> 
> Let me know what you think,
> Maxime

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/3145d100/attachment.sig>
