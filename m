From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 04 Apr 2014 16:14:05 +0200
Subject: [PATCH] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <8799740.0uZJLUBGY1@wuerfel>
References: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
 <8799740.0uZJLUBGY1@wuerfel>
Message-ID: <1396620845.19661.14.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-04-04 at 13:39 +0200, Arnd Bergmann wrote:
> The PLAT_SPEAR_SINGLE symbol in Kconfig
> is a leftover from an earlier patch I did that never got merged,
> and we should just remove that.

Correct, see http://thread.gmane.org/gmane.linux.kernel/1646112 . It
seems nothing happened after that. I'm planning on sending a reminder if
PLAT_SPEAR_SINGLE is still mentioned in v3.15-rc1.


Paul Bolle
