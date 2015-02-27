From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 27 Feb 2015 19:22:45 +0800
Subject: [PATCH v9 21/21] ARM64 / ACPI: additions of ACPI documentation
 for arm64
In-Reply-To: <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54F05385.2080506@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/25 16:40, Hanjun Guo wrote:
> +Not yet implemented are:
> +
> +	-- Section 10: power source and power meter devices
> +
> +	-- Section 11: thermal management
> +
> +	-- Section 12: embedded controllers interface
> +
> +	-- Section 13: SMBus interfaces
> +
> +	-- Section 17: NUMA support (prototypes have been submitted for
> +	   review)
> +
> 

Here at the end of the file. Redundant blank line.

> +ACPI is also important because hardware and OS vendors have already worked
> +out how to use it to support the general purpose ecosystem. The infrastructure
> +is in place, the bindings are in place, and the process is in place. DT does
> +exactly what we need it to when working with vertically integrated devices,
> +but we don?t have good processes for supporting what the server vendors need.
> +We could potentially get there with DT, but doing so doesn?t buy us anything.
> +ACPI already does what the hardware vendors need, Microsoft won?t collaborate
> +with us on DT, and the hardware vendors would still need to provide two
> +completely separate firmware interface; one for Linux and one for Windows.
> +

And Here at the end of the file. Redundant blank line.

-- 
Thanks,
Shannon
