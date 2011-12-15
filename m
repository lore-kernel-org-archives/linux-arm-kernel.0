From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 15 Dec 2011 08:31:26 +0800
Subject: serial tty name
In-Reply-To: <4EE8C16F.8060501@calxeda.com>
References: <20111214144344.GA2090@richard-laptop>
 <4EE8C16F.8060501@calxeda.com>
Message-ID: <20111215003125.GN28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:31:59AM -0600, Rob Herring wrote:
> Richard,
> 
> On 12/14/2011 08:43 AM, Richard Zhao wrote:
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
> 
> That's what the aliases are for.
so, why do I see people define uart aliases in $SOC.dtsi, rather not in $BOARD.dts?

Thanks
Richard
> 
> Rob
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
