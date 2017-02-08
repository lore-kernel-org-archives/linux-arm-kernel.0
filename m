From: panand@redhat.com (Pratyush Anand)
Date: Wed, 8 Feb 2017 11:09:23 +0530
Subject: [PATCH v32 00/13] arm64: add kdump support
In-Reply-To: <20170207080601.5816-1-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
Message-ID: <d3759cc9-01d8-814c-e76e-e035eac6bb8b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 07 February 2017 01:36 PM, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v5 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.8 or later, i.e. master for now) [3]
>
> I tested this patchset on fast model and hikey.
> (under various configurations, in particular 4KB-page/39,48-bits, 64KB-page/42
> -bits with hibernate)
>
> The previous versions were also:
> Tested-by: Pratyush Anand <panand@redhat.com> (v29, mustang and seattle)

..and you have my Tested-by for this series as well. They work fine with 
both the above platform.

Although we are very close, still it could be great if these patches can 
make into v4.11.

Thanks a lot Akashi for the quick v32.

~Pratyush
