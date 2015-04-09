From: pavel@denx.de (Pavel Machek)
Date: Thu, 9 Apr 2015 11:42:24 +0200
Subject: rootdelay regression is back in 4.0? was Re: [PATCH] Revert "init:
 make rootdelay=N consistent with rootwait behaviour"
In-Reply-To: <20140918131716.GA29533@amd>
References: <20140917142542.GA5225@windriver.com>
 <1410965865-5547-1-git-send-email-paul.gortmaker@windriver.com>
 <20140918131716.GA29533@amd>
Message-ID: <20150409094224.GA7499@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2014-09-18 15:17:16, Pavel Machek wrote:
> On Wed 2014-09-17 10:57:45, Paul Gortmaker wrote:
> > This reverts commit 4dfe694f616e00e6fd83e5bbcd7a3c4d7113493d.
> 
> This solves my problems, thanks.

Weird. It seems this regression is back in 4.0-rc7?

root=0xb302 works, root=/dev/mmcblk0p2 does not. socfpga board.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
