From: panand@redhat.com (Pratyush Anand)
Date: Fri, 6 Jan 2017 08:56:30 +0530
Subject: [PATCH v29 0/9] arm64: add kdump support
In-Reply-To: <20161228043347.27358-1-takahiro.akashi@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
Message-ID: <610620b2-d77d-0684-144f-0f76d0cdbb5e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 28 December 2016 10:03 AM, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v4 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.7 or later) [3]
>     (As of today, the very latest tree cannot handle a core image correctly
>      due to the commit 7fd8329ba502 ("taint/module: Clean up global and module
>      taint flags handling")
>
>
> The previous version, v27, was also:
> Tested-by: Pratyush Anand <panand@redhat.com> (mustang and seattle)

You have my "Tested-by" for this version as well :-). Patches works 
great after applying them over v4.10-rc2.

I used crash-utility from below where there are few patches queued for 
crash-7.1.8
https://github.com/crash-utility/crash

~Pratyush
