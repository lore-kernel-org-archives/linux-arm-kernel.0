From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 22:20:20 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Clock Fixes for v3.18
In-Reply-To: <cover.1415757100.git.horms+renesas@verge.net.au>
References: <cover.1415757100.git.horms+renesas@verge.net.au>
Message-ID: <201411192220.20365.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC clock fixes for v3.18.
> Or alternatively for v3.19 if you feel they are too late for v3.18.
> 

I've merged all three 'fixes' pull requests you had into the fixes
branch:

Renesas ARM Based SoC Clock Fixes for v3.18
Renesas ARM Based SoC DT Fixes for v3.18
Renesas ARM Based SoC Fixes for v3.18

I'm still waiting for a reply from Olof, since he seems to have
skipped them last week when he sent the fixes pull request to Linus.
If he had already decided to postpone the branches for 3.19, I'll
just undo the merge here and put it into next/fixes-non-critical
instead, I'm fine with it either way.

	Arnd
