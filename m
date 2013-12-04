From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 22:17:39 +0800
Subject: [RFC part1 PATCH 4/7] ARM64 / ACPI: Introduce the skeleton of
 _PDC related for ARM64
In-Reply-To: <20131203165318.2c04a8bf@alan.etchedpixels.co.uk>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-5-git-send-email-hanjun.guo@linaro.org>
 <20131203165318.2c04a8bf@alan.etchedpixels.co.uk>
Message-ID: <529F3983.5000200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 00:53, One Thousand Gnomes wrote:
> O> +enum idle_boot_override { IDLE_NO_OVERRIDE = 0, IDLE_HALT, IDLE_NOMWAIT,
>> +			IDLE_POLL, IDLE_FORCE_MWAIT };
> This should probably move out of the arch directory to be a single enum
> including both platforms values. That will make it rather easier to keep
> sane and avoid ifdefs around which definitions are for which processor.

Thank you very much for the suggestion, it makes sense to me, will figure
out how to implement it.

Thanks
Hanjun
