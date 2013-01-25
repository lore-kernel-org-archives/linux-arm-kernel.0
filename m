From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 11:15:47 +0000
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <cover.1359091286.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
Message-ID: <201301251115.47480.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 January 2013, Jason Cooper wrote:
> This is a second cut at cleaning up mach-kirkwood/.  There are a few DT
> conversions (topkick -> mvsdio, pinctrl) which, once reviewed, I'll put in the
> normal pull request cycle.
> 
> The others which remove board-*.c files, I'll keep updating against
> mvebu/for-next, and then apply at the end of the merge window.
> 
> Please test as you are able.

Great work, it's really nice to see where things are going now!

In patch 7, the changeset text seems to be indented wrong, but the
patch is still good.

I wonder if it makes sense to collapse the few remaining DT based
board files now and move their entire contents back into board-dt.c.
Of course, if you think they will all be gone soon anyway, there
is no point.

	Arnd
