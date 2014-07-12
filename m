From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 13 Jul 2014 00:13:57 +0200
Subject: [PATCHv2 01/10] ARM: dts: OMAP2+: Add mailbox fifo and user
 information
In-Reply-To: <1405115083-52977-2-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
 <1405115083-52977-2-git-send-email-s-anna@ti.com>
Message-ID: <20140712221357.GA17930@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-07-11 16:44:34, Suman Anna wrote:
> The number of mailbox fifos and users (IP interrupts) are added
> to the Mailbox DT nodes on OMAP2420, OMAP2430, OMAP3, and OMAP5
> family of SoCs through the DT properties "ti,mbox-num-fifos" and
> "ti,mbox-num-users" properties. This data represents the same data
> that used to be represented in hwmod attribute data through the
> .num_fifos and .num_users fields previously.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
