From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 21:36:13 +0100
Subject: [PATCH 1/6] ASoC: codecs/wm8682: use __devexit_p
In-Reply-To: <1317587284-2776-2-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-2-git-send-email-arnd@arndb.de>
Message-ID: <20111002203613.GA5811@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 10:27:59PM +0200, Arnd Bergmann wrote:
> This fixes a build error when CONFIG_HOTPLUG is disabled.

Axel Lin sent a patch for this recently, it's already been merged.

>  sound/soc/codecs/wm8782.c |    2 +-

Your subject line doesn't match the file you're changing.
