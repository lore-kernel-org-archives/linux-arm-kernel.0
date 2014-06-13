From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 13 Jun 2014 14:10:51 +0100
Subject: [STLinux Kernel] Latest mainline (3.16 merge window) does not
 boot in B2020/STiH416
In-Reply-To: <539AF5B0.6060509@linaro.org>
References: <539AF5B0.6060509@linaro.org>
Message-ID: <20140613131051.GA28309@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 13 Jun 2014, Daniel Thompson wrote:
> Hi Folks
> 
> Using the lastest Linus T. mainline it is no longer possible to boot a
> B2020/STiH416.
> 
> The kernel boots OK and issues UART messages, but the system gets stuck
> trying to mount the NFS root filesystem.

Are you booting with  clk_ignore_unused kernel parameter?

Its about at the point you describe that the unused clocks are disabled.

regards,

Peter.
