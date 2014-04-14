From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 14 Apr 2014 10:42:06 +0200
Subject: Device tree support for Atmel AC97 controller on AT91SAM9263
In-Reply-To: <1397293707-26890-1-git-send-email-alexanders83@web.de>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
Message-ID: <s5h38hgnvz5.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Sat, 12 Apr 2014 11:08:23 +0200,
Alexander Stein wrote:
> 
> This set of patches add device tree support for the AC97 controller found
> on AT91SAM9263.
> The first two patches are minor cleanup, while the last ones add the actual
> support.

Do you really need work on this driver?  The sound/atmel/* stuff is an
old one before ASoC was introduced, mostly obsoleted nowadays.


Takashi
