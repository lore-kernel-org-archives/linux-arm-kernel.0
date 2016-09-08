From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 08:22:15 +0200
Subject: [PATCH v4 3/8] dts: sun8i-h3: move uart0 pinmux/peripheral
 assocation to DSTI
In-Reply-To: <1473235141-12768-4-git-send-email-jorik@kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
 <1473235141-12768-4-git-send-email-jorik@kippendief.biz>
Message-ID: <20160908062215.GC8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 09:58:56AM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> This is the only sensible pinmux/peripheral association for uart0, so I have
> moved it from the board specific DTS to the DTSI. It is still up to the boards
> to enable it, though.
> 
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

There's really several options for the UART0 to be muxed, so it's
better if we leave that to the board entirely.

That's useful only for pins where you truely have only a single
option in the entire SoC.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/96e20669/attachment.sig>
