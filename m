From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 13 Jan 2018 11:51:15 +0000
Subject: [PATCH V4 0/3] Map larger kernels at early init
In-Reply-To: <20180111101159.9748-1-steve.capper@arm.com>
References: <20180111101159.9748-1-steve.capper@arm.com>
Message-ID: <20180113115114.xamczdijuggzdt4c@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 10:11:56AM +0000, Steve Capper wrote:
> Steve Capper (3):
>   arm64: Re-order reserved_ttbr0 in linker script
>   arm64: entry: Move the trampoline to be before PAN
>   arm64: Extend early page table code to allow for larger kernels

I queued the patches for 4.16. I'll push them out once my tests
complete.

Thanks.

-- 
Catalin
