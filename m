From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 13:15:20 +0000
Subject: [PATCH] ARM: optimize for FA526 if toolchain supports it
In-Reply-To: <1335184313-27573-1-git-send-email-florian@openwrt.org>
References: <1335184313-27573-1-git-send-email-florian@openwrt.org>
Message-ID: <201204231315.20648.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012, Florian Fainelli wrote:
> Currently, when we are targetting a Farady FA526-based system
> the toolchain will use the arm9tdmi mtune option of gcc, gcc > 4.6
> supports the FA526 CPU, and allow us to optimize for it.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

No objections to the patch, but a question out of curiosity:

Is this the regular gemini platform that you are working on,
or something else? Do you have other platform support patches
that you are planning to submit for this?

	Arnd
