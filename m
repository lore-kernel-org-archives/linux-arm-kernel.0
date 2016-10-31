From: robh@kernel.org (Rob Herring)
Date: Mon, 31 Oct 2016 00:10:39 -0500
Subject: [PATCH v2 1/4] arm64: arch_timer: Add device tree binding for
 hisilicon-161601 erratum
In-Reply-To: <1477553651-13428-1-git-send-email-dingtianhong@huawei.com>
References: <1477553651-13428-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <20161031051039.vkuykdc4sgrh6scz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 03:34:08PM +0800, Ding Tianhong wrote:
> This erratum describes a bug in logic outside the core, so MIDR can't be
> used to identify its presence, and reading an SoC-specific revision
> register from common arch timer code would be awkward.  So, describe it
> in the device tree.
> 
> v2: Use the new erratum name and update the description.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
