From: nicolas.dechesne@linaro.org (Nicolas Dechesne)
Date: Thu, 2 Nov 2017 16:21:03 +0100
Subject: [PATCH] arm64: defconfig: enable USB host and IOMMU for msm8916
In-Reply-To: <20171101195714.26729-1-robh@kernel.org>
References: <20171101195714.26729-1-robh@kernel.org>
Message-ID: <CAP71WjzvhSHtLLJo+7brEfxbFr9dUo4OJCLXihT5dy5KkM6qXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 8:57 PM, Rob Herring <robh@kernel.org> wrote:
> Add config options needed on DB410c and other msm8916 based boards for
> the IOMMU and USB host. The IOMMU is needed to enable the GPU.
>

The USB bits below are already taken care in a patch from Alex Elder 2
weeks ago, see [1]

The IOMMU bit has been applied by Arnd already as well, see [2]

[1] https://patchwork.kernel.org/patch/10008457
[2] https://patchwork.kernel.org/patch/9999911/
