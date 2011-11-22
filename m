From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Nov 2011 13:45:49 +0800
Subject: [PATCH] ARM: mxs: fix machines' initializers order
In-Reply-To: <1321865755-7423-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1321865755-7423-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20111122054548.GE16417@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 10:55:55AM +0200, Lauri Hintsala wrote:
> Initializers of m28evk and stmp378x_devb fixed to be in order
> they are called.
> 
> ---

You may not want to put a '---' here, because all the texts after
that will get dropped when I run 'git am' to apply the patch.  I
have applied the patch with this fixed.  Thanks.

Regards,
Shawn

> reference: http://article.gmane.org/gmane.linux.ports.arm.omap/50721
> 
> cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> ---
