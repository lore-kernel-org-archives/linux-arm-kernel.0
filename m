From: panand@redhat.com (Pratyush Anand)
Date: Mon, 20 Mar 2017 18:12:48 +0530
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
Message-ID: <2d0f8fbf-f815-e773-9a6b-05242eb9abfd@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 15 March 2017 03:26 PM, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v6 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.8 or later) [3]
>
> I tested this patchset on fast model and hikey.
>
> The previous versions were also:
> Tested-by: Pratyush Anand <panand@redhat.com> (v32, mustang and seattle)

You have it for this version as well.

Thanks for the patchset.

~Pratyush
