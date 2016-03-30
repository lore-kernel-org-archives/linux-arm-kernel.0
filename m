From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 30 Mar 2016 16:05:04 +0800
Subject: [PATCH v2] ARM: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
In-Reply-To: <56FB87FA.50405@linaro.org>
References: <1459324077-7116-1-git-send-email-jszhang@marvell.com>
 <56FB87FA.50405@linaro.org>
Message-ID: <20160330160504.50be1959@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

On Wed, 30 Mar 2016 10:02:02 +0200 Daniel Lezcano wrote:

> On 03/30/2016 09:47 AM, Jisheng Zhang wrote:
> > Currently, we check cpuidle_ops.suspend every time when entering a
> > low-power idle state. But this check could be avoided in this hot path
> > by moving it into arm_cpuidle_read_ops() to reduce arm_cpuidle_suspend
> > overhead a bit.  
> 
> This patch makes sense but the ARM64 part is missing.
> 

Here is the ARM64 part, you are also in the "To" list ;)

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/417713.html

Thanks,
Jisheng
