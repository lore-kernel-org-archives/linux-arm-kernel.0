From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Sep 2011 22:49:26 +0200
Subject: [PATCHv3 0/4] Initial support for Picochip picoXcell
In-Reply-To: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
References: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
Message-ID: <201109302249.26525.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On Monday 26 September 2011, Jamie Iles wrote:
> This is largely a repost of v2, but with a couple of minor changes:
>         - Removed bootargs from board dts files
>         - Fix up the VIC binding documentation
> 
> I've also added a 4th patch which removes the picoxcell specific ioremap
> functionality.  This could either be applied/folded into the first patch
> if Nicolas' vmalloc cleanups go in.
> 
> These patches can also be found in a git tree at:
> 
>         git://github.com/jamieiles/linux-2.6-ji.git for-next

I've pulled it into the next/soc branch now, and I'll also pul
Rob's highbank patches in there.

Sorry for taking so long.

There might be a few things that break when this is merged with the
cross-platform changes, so I'm planning right now to submit these
rather late in the merge window to allow fixing any mismerges
before it gets upstream.

	Arnd
