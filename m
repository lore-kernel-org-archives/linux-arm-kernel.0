From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 17 Jul 2012 21:27:47 +0800
Subject: [PATCH for 3.6] ARM: mxs: fix the changed OF interface in MAC
 update function
In-Reply-To: <1342510560-24584-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1342510560-24584-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20120717132746.GC3109@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 10:36:00AM +0300, Lauri Hintsala wrote:
> Commit 475d009429 "of: Improve prom_update_property() function" changes
> the usage of prom_update_property function. Fix compiler error and start
> to use the new improved interface.
> 
> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> ---
> 
> Linux-next is broken becase of prom_update_property interface change.
> 
Thanks, Lauri.

I already sent a fix as below.

http://article.gmane.org/gmane.linux.kernel.next/23330

Regards,
Shawn
