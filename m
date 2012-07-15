From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 15 Jul 2012 23:00:03 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20120715144935.GB2429@S2100-06.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
Message-ID: <20120715150003.GD2429@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2012 at 10:49:35PM +0800, Shawn Guo wrote:
> below.  But does that mean ethernet PHY does not work even on non-DT
> kernel right now?
> 
So I guess you need something like c46d291 (ARM: apx4devkit: fix FEC
enabling PHY clock) for TX28 too.

-- 
Regards,
Shawn
