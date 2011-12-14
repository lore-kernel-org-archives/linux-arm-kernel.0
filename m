From: rob.herring@calxeda.com (Rob Herring)
Date: Wed, 14 Dec 2011 09:31:59 -0600
Subject: serial tty name
In-Reply-To: <20111214144344.GA2090@richard-laptop>
References: <20111214144344.GA2090@richard-laptop>
Message-ID: <4EE8C16F.8060501@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard,

On 12/14/2011 08:43 AM, Richard Zhao wrote:
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

That's what the aliases are for.

Rob
