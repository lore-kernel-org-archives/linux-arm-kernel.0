From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Dec 2016 15:05:38 +0100
Subject: [PATCH] dts: sun8i-h3: correct UART3 pin definitions
In-Reply-To: <20161204122948.11921-1-jorik@kippendief.biz>
References: <20161204122948.11921-1-jorik@kippendief.biz>
Message-ID: <20161206140538.ag7nofyca2n5ror2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jorik,

On Sun, Dec 04, 2016 at 01:29:48PM +0100, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> In a previous commit, I made a copy/paste error in the pinmux
> definitions of UART3: PG{13,14} instead of PA{13,14}. This commit takes
> care of that. I have tested this commit on Orange Pi PC and Orange Pi
> Plus, and it works for these boards.
> 
> Fixes: e3d11d3c45c5 ("dts: sun8i-h3: add pinmux definitions for
> UART2-3")
> 
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

Thanks!

This looks like a late fix for the current release which comes to an
end. Can you resend it with arm at kernel.org as a recipient, so that the
ARM SoC maintainers can apply it directly?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161206/c8a8bd19/attachment.sig>
