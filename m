From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 04 Dec 2014 10:18:27 -0800
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <1417707993-82290-1-git-send-email-agraf@suse.de>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
Message-ID: <5480A573.4090801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/2014 7:46 AM, Alexander Graf wrote:
> With binutils 2.25 the default alignment for 32bit arm sections changed to
> have everything 64k aligned. Armv7 binaries built with this binutils version
> run successfully on an arm64 system.
>
> Since effectively there is now the chance to run armv7 code on arm64 even
> with 64k page size, it doesn't make sense to block people from enabling
> CONFIG_COMPAT on those configurations.
>

It's good to see this restriction dropped. Can we put a note somewhere
in the actual Kconfig about the binutils requirement so the requirements
are more obvious?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
