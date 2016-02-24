From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Feb 2016 17:39:02 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <s5hziuqcby1.wl-tiwai@suse.de>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <3238725.1iS2dg6EkI@wuerfel> <s5hziuqcby1.wl-tiwai@suse.de>
Message-ID: <2576612.maDBOzAeKt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 February 2016 17:25:42 Takashi Iwai wrote:
> 
> Thanks for catching this.  Yes, your fix is correct.  This must have
> been a wrong pick up when converting from the standalone hda jack to
> unified jack stuff.
> 
> Could you send a proper patch for inclusion?

Ok, done.

	Arnd
