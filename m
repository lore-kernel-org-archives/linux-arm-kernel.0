From: panand@redhat.com (Pratyush Anand)
Date: Wed, 2 Nov 2016 15:09:35 +0530
Subject: [PATCH v27 0/9] arm64: add kdump support
In-Reply-To: <20161102044959.11954-1-takahiro.akashi@linaro.org>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
Message-ID: <e9d49b0b-f4e6-13af-f963-5e42191cb24e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 02 November 2016 10:19 AM, AKASHI Takahiro wrote:
>     v27-specific note: In this version, the change made in v26 was reverted
>     because I've got a comment that /reserved-memory DT property should
>     not be used on UEFI/ACPI systems, even though it is workable under
>     the current implementation. I've also confirmed that Rob doesn't argue
>     any more against using "linux,usable-memory-range".
>     So v27 is essentially the same as v25.
>
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v4 [2].
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.6 or later) [3]

Tested with mustang and seattle.
Tested-by: Pratyush Anand <panand@redhat.com>
