From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 15 Mar 2013 13:49:34 +0100
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <1363299178-8241-4-git-send-email-arnd@arndb.de>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <1363299178-8241-4-git-send-email-arnd@arndb.de>
Message-ID: <514318DE.8060601@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/14/13 23:12, Arnd Bergmann a ?crit :
> With the Cortina Gemini platform gone, nothing in ARM uses
> the Faraday 526 CPU core support any more. There is at least
> one other platform using this (Moschip MCS814x), but the
> efforts to get that merged into mainline appear to have
> stalled.

I was actually wrong for MCS8140, they used a genuine ARM926EJS core, 
newer version like MCS8142 and MCS8144 use a FA626 core that the 
mainline kernel does not support anyway.

Someone recently announced support for a Moxart SoC which seems to use 
the FA526 core however.

>
> If someone still needs this code, please speak up now,
> otherwise we will remove it now. Of course there is
> always the option to revert this patch if we need it
> again later.
--
Florian
