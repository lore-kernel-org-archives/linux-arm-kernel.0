From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 07 Jan 2013 14:00:35 +0100
Subject: [RFC 0/3] future of gemini platform
In-Reply-To: <1357310500-19848-1-git-send-email-arnd@arndb.de>
References: <1357310500-19848-1-git-send-email-arnd@arndb.de>
Message-ID: <50EAC6F3.1020206@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Le 01/04/13 15:41, Arnd Bergmann a ?crit :
> The gemini platform is quite broken at the moment due to bitrot,
> here are the two suggested solutions. We should either apply the
> first patch or the other two, depending on whether anyone still
> uses this.
>
> Ulli was last actively working on this about two years ago,
> so I assume that he has moved on, but if he or anyone else
> is still interested in keeping Gemini alive, any patches
> and testing are very welcome. Without a maintainer however,
> I see no point in keeping it.
>
> The fa526 CPU support is currently only used on Gemini,
> but Florian had some patches last year for it, so he might
> still need it. If there are still plans to get MCS814x
> or another fa526 based platform merged into mainline,
> we can keep this around, but unless I see a timeline
> for this, I would prefer to remove it for now. It should
> be trivial to revert that patch and bring it back if
> it's needed for a new platform.

I did not have actually hardware to port MCS814x to anything else than 
MCS8140 (real ARM 926EJS core), while MCS8142 and MCS8144 actually use a 
FA626 (not 526) core. Added in CC are Imre and Gabor who actually worked 
on the Gemini machine and might be able to either give their go for 
removal, or fix the issues.
--
Florian
