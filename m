From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Feb 2012 17:43:03 +0000
Subject: [GIT PULL] LPC32xx fixes for v3.3-rc4
In-Reply-To: <4F4BB380.30803@antcom.de>
References: <4F490CC0.5050303@antcom.de> <201202271409.52470.arnd@arndb.de>
 <4F4BB380.30803@antcom.de>
Message-ID: <201202271743.03673.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 February 2012, Roland Stigge wrote:
> Right. I replaced the mentioned branch with
> 
> * lpc32xx/fixes-non-critical (singled out the macros fixes, for next)
> * lpc32xx/fixes (the remaining 5 patches as immediate fixes)
> 
> Please note that although it's a typo fix in the macros, it's also an
> internal API change.

I would not regard that patch any different because it changes
symbol names in the header file: The kernel internal API has absolutely
no relevance and can be changed in any (helpful) way as long as you
change all the in-kernel users at the same time.

> I also added the stable-CC to the "lpc32xx/fixes" and added the note
> about NXP's HW bugfix as suggested by Wolfram.
> 
> I'll regenerate the pull request. Please tell me if you also like to
> have the patches re-posted.

Ok, thanks a lot! There is no need to resend the patches, since they
have not changed.

	Arnd
