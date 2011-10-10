From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 10 Oct 2011 18:54:38 +0200
Subject: [PATCH] PM: HIBERNATION: add resume_delay kernel param as well
	as resume_delay
In-Reply-To: <1318225452-10397-1-git-send-email-Barry.Song@csr.com>
References: <1318225452-10397-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20111010165437.GA11093@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2011-10-09 22:44:12, Barry Song wrote:
> From: Barry Song <baohua.song@csr.com>
> 
> patch "PM: HIBERNATION: add resume_wait param to support MMC-like devices
> as resume file" add resume_wait param. this patch adds resume_delay so that
> resume_wait/delay has the same model with root_wait/delay.
> 
> Signed-off-by: Barry Song <baohua.song@csr.com>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
