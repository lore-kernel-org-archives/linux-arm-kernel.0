From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 08:17:34 +0200
Subject: [PATCH v4 1/8] dts: sun8i-h3: drop _a and address suffix from
 uart0 pinmux
In-Reply-To: <1473235141-12768-2-git-send-email-jorik@kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
 <1473235141-12768-2-git-send-email-jorik@kippendief.biz>
Message-ID: <20160908061734.GA8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 07, 2016 at 09:58:54AM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> These are the only possible pins for UART0 on H3

That's not true, you can also mux it on PF2 / PF4.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/30e9ae80/attachment.sig>
