From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 11:33:17 -0800
Subject: [PATCH v5 2/4] dts: sun8i-h3: Add APB0 related clocks and resets
In-Reply-To: <1456146208-13890-3-git-send-email-k@japko.eu>
References: <1456146208-13890-1-git-send-email-k@japko.eu>
 <1456146208-13890-3-git-send-email-k@japko.eu>
Message-ID: <20160225193317.GM4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 02:03:26PM +0100, Krzysztof Adamski wrote:
> APB0 is bearly mentioned in H3 User Manual and it is only setup in the
> Allwinners kernel dump for CIR. I have verified experimentally that the
> gate for R_PIO exists and works, though. There are probably other gates
> there but I don't know their order right now and I don't have access to
> their peripherals on my board to test them.
> 
> After some experiments and reviewing how this is organized on other
> sunxi SoCs, I couldn't actually find any way to disable clocks for R_PIO
> and they are working properly without doing anything so I assume they
> are connected straight to the 24Mhz oscillator for now.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/80559ed0/attachment.sig>
