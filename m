From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 May 2016 09:05:55 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: n900 needs MMC slot names for legacy
 user space
In-Reply-To: <1461714383-9956-2-git-send-email-tony@atomide.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
 <1461714383-9956-2-git-send-email-tony@atomide.com>
Message-ID: <20160502070555.GA13215@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-04-26 16:46:22, Tony Lindgren wrote:
> Let's pass the slot names in pdata like the legacy code does.
> Once we have a generic DT binding for the slot names we can
> switch to that.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
