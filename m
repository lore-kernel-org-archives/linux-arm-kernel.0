From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Dec 2011 22:43:47 +0800
Subject: serial tty name
Message-ID: <20111214144344.GA2090@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How to map different uart port to ttymxc0 (take imx for example)?

In rootfs, it usually "getty ttymxc0"  to get
serial console. And the rootfs may be shared by different boards.
Traditionaly way is to set right platform device ID.

But with DT, UART2 always generate ttymxc1, UART3 for ttymxc2. You
always needs to modify the getty command when your change another board.

Is there a way to fix it?


Thanks
Richard
