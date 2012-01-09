From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 9 Jan 2012 11:10:37 +0100
Subject: [PATCH] PM:Hibernation: drop the check of swap space size for
 compressed image
In-Reply-To: <1326084983-22237-1-git-send-email-Barry.Song@csr.com>
References: <1326084983-22237-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20120109101037.GB19903@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2012-01-09 12:56:23, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> For compressed image, the space required is not known until
> we finish compressing and writing all pages.
> This patch drops the check, and if swap space is not enough
> finally, system can still restore to normal after writing
> swap fails for compressed images.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
