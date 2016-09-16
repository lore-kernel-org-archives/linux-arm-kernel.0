From: james.morse@arm.com (James Morse)
Date: Fri, 16 Sep 2016 17:04:45 +0100
Subject: [PATCH v26 4/7] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
In-Reply-To: <20160907042908.6232-5-takahiro.akashi@linaro.org>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-5-takahiro.akashi@linaro.org>
Message-ID: <57DC181D.20206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/16 05:29, AKASHI Takahiro wrote:
> For the current crash utility, we need to know, at least,
>   - kimage_voffset
>   - PHYS_OFFSET
> to handle the contents of core dump file (/proc/vmcore) correctly due to
> the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
> This patch puts them as VMCOREINFO's into the file.
> 
>   - VA_BITS
> is also added for makedumpfile command.
> More VMCOREINFO's may be added later.


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
