From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 4 Feb 2011 14:36:08 +0100
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20110204133556.GA2803@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu 2011-01-20 12:32:38, Daniel Walker wrote:
> This series adds basic Nexus One support which includes a booting
> kernel, and functional MMC .
> 
> Most people won't be able to use this yet unfortunately because
> you need a serial cable to get any output. However, it's a start.

>   msm: mahimahi: add mahimahi board file
>   msm: mahimahi: add in mmc support code
>   msm: mahimahi: add gpio pin muxing code
>   msm: mahimahi: initialize mmc at start up

Even you call the machine Nexus One... can  you be a tiny bit more
consistent with it?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
