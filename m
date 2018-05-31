From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 22:55:01 -0500
Subject: [PATCH v2 12/12] coresight: tmc: Add configuration support for
 trace buffer size
In-Reply-To: <1527599737-28408-13-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
 <1527599737-28408-13-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180531035501.GA15549@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 02:15:37PM +0100, Suzuki K Poulose wrote:
> Now that we can dynamically switch between contiguous memory and
> SG table depending on the trace buffer size, provide the support
> for selecting an appropriate buffer size.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  8 ++++++
>  .../devicetree/bindings/arm/coresight.txt          |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/hwtracing/coresight/coresight-tmc.c        | 33 ++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
