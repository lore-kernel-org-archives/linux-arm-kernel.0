From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 5 Mar 2015 01:54:24 +0100
Subject: [PATCH 4.0-rc1 v17 5/6] x86/nmi: Use common printk functions
In-Reply-To: <1425463974-23568-6-git-send-email-daniel.thompson@linaro.org>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-6-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150305005424.GA21715@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Daniel Thompson <daniel.thompson@linaro.org> wrote:

> Much of the code sitting in arch/x86/kernel/apic/hw_nmi.c to support 
> safe all-cpu backtracing from NMI has been copied to printk.c to 
> make it accessible to other architectures.
> 
> Port the x86 NMI backtrace to the generic code.

Is there any difference between the generic and the x86 code as they 
stand today?

Thanks,

	Ingo
