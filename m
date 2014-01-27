From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 27 Jan 2014 20:07:04 +0900
Subject: [PATCH 0/2] Replace /include/ (dtc) with #include
In-Reply-To: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
References: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <52E63DD8.9070909@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 07:16 PM, Pankaj Dubey wrote:
> Replace /include/ (dtc) with #include (C pre-processor) for all ARM64
> based SoC dts files.
>
> Pankaj Dubey (2):
>    arm64: dts: use #include for all AppliedMicro device tree files
>    arm64: dts: use #include for all ARM fast model device tree file
>
>   arch/arm64/boot/dts/apm-mustang.dts    |    2 +-
>   arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
Gentle ping.

Best Regards,
Pankaj Dubey
