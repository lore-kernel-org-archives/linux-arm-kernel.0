From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 Dec 2011 11:56:37 +0800
Subject: serial tty name
In-Reply-To: <20111214144344.GA2090@richard-laptop>
References: <20111214144344.GA2090@richard-laptop>
Message-ID: <20111219035636.GE4962@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 10:43:47PM +0800, Richard Zhao wrote:
> How to map different uart port to ttymxc0 (take imx for example)?
> 
> In rootfs, it usually "getty ttymxc0"  to get
> serial console. And the rootfs may be shared by different boards.
> Traditionaly way is to set right platform device ID.
> 
> But with DT, UART2 always generate ttymxc1, UART3 for ttymxc2. You
> always needs to modify the getty command when your change another board.
> 
> Is there a way to fix it?
> 
I'm using Linaro rootfs and do not see this problem at all.  So as
people have suggested, you need to fix it in your user space.

-- 
Regards,
Shawn
