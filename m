From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jan 2014 16:02:29 +0100
Subject: [PATCH 1/4] clk: sunxi: Add support for PLL6 on the A31
In-Reply-To: <20140117221402.4167.78251@quantum>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389892285-11745-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140117221402.4167.78251@quantum>
Message-ID: <20140127150229.GM3867@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Fri, Jan 17, 2014 at 02:14:02PM -0800, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-01-16 09:11:22)
> > The A31 has a slightly different PLL6 clock. Add support for this new clock in
> > our driver.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> This looks good to me. I guess it will be going in for 3.15 based on the
> comments in the coverletter.

Yes, indeed it is 3.15 materials.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/99d8f2d3/attachment.sig>
