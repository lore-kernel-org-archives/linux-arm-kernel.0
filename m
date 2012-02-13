From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Feb 2012 07:01:37 +0000
Subject: [PATCH] ep93xx: fix build of vision_ep93xx.c
In-Reply-To: <201202130658.12505.arnd@arndb.de>
References: <201202080953.44853.hartleys@visionengravers.com>
 <ADE657CA350FB648AAC2C43247A983F001F41F9DF77C@AUSP01VMBX24.collaborationhost.net>
 <201202130658.12505.arnd@arndb.de>
Message-ID: <201202130701.38027.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 February 2012, Arnd Bergmann wrote:
> It should indeed go through the arm-soc tree, I'm sorry for having
> been so unresponsive recently. Olof was taking care of the other
> pull requests and bug fixes but unfortunately was not on Cc on this
> one, so we both ended up missing it until now.
> 
> I've applied it on the "fixes" branch of the arm-soc tree now, it
> will get sent to Linus on the next opportunity.
> 
> I had a little trouble applying the patch from base64 format, but
> since you've had to wait so long already and I'm not completely sure
> which side the problem was on I took the time to recreate the diff
> from the base64 encoding and fix up the whitespace damage I got.
> 

One more comment: if you want to ensure a patch or pull request
for arm-soc reaches us, please send it to arm at kernel.org. This should
let us make sure that at least one of us reacts in a way that you
deserve instead of letting it fall under the table.

	Arnd
