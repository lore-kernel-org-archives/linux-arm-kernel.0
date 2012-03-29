From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Mar 2012 11:02:47 -0700
Subject: [PATCH] ARM: LPC32xx: clock.c: Fix lpc-eth clock reference
In-Reply-To: <1332974996-13045-1-git-send-email-stigge@antcom.de>
References: <1332974996-13045-1-git-send-email-stigge@antcom.de>
Message-ID: <20120329180247.GB2659@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 12:49:56AM +0200, Roland Stigge wrote:
> During a complex merge for v3.4, one line of the commit
> c20b909be9ba27173294a52d08cab293ec030a2c ("ARM: LPC32xx: Ethernet support") was
> reverted wrongly ("lpc-eth.0" -> "lpc-net.0") while the other conflicts were
> merged correctly. This patch re-applies the clock name "lpc-eth.0".
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> ---
>  Applies on top of Olof's 1f5b7dcfdad3840d4bce27ab0b3cc8f376b81544 in
>  preparation of v3.4-rc1


Looks like it was me who messed up the conflict resolution, apologies
about that. Applied to fixes branch for 3.4-rc.


-Olof
