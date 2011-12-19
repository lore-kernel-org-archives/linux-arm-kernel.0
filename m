From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 19 Dec 2011 13:40:13 +0800
Subject: serial tty name
In-Reply-To: <20111219035636.GE4962@S2100-06.ap.freescale.net>
References: <20111214144344.GA2090@richard-laptop>
 <20111219035636.GE4962@S2100-06.ap.freescale.net>
Message-ID: <20111219054012.GA15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 11:56:37AM +0800, Shawn Guo wrote:
> On Wed, Dec 14, 2011 at 10:43:47PM +0800, Richard Zhao wrote:
> > How to map different uart port to ttymxc0 (take imx for example)?
> > 
> > In rootfs, it usually "getty ttymxc0"  to get
> > serial console. And the rootfs may be shared by different boards.
> > Traditionaly way is to set right platform device ID.
> > 
> > But with DT, UART2 always generate ttymxc1, UART3 for ttymxc2. You
> > always needs to modify the getty command when your change another board.
> > 
> > Is there a way to fix it?
> > 
> I'm using Linaro rootfs and do not see this problem at all.  So as
> people have suggested, you need to fix it in your user space.
Why not past your linaro rootfs solution?

Thanks
Richard
> 
> -- 
> Regards,
> Shawn
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
