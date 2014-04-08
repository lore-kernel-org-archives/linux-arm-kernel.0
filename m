From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 8 Apr 2014 16:26:20 -0700
Subject: [PATCH v2] ARM: qcom: Add initial APQ8064 SoC and IFC6410 board
 device trees
In-Reply-To: <1396972391-11759-1-git-send-email-galak@codeaurora.org>
References: <1396972391-11759-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140408232619.GL9985@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08, Kumar Gala wrote:
> Add basic APQ8064 SoC include device tree and support for basic booting on
> the IFC6410 board.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> v2:
> * created a v2.0 apq8064.dtsi to handle differences in Si rev in future
> * changed /include/ to #include
> * added PMU node
> * dropped interrupts from cpus node, not currently part of binding
> 
> 
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  12 +++
>  arch/arm/boot/dts/qcom-apq8064-v2.0.dtsi   |   1 +
>  arch/arm/boot/dts/qcom-apq8064.dtsi        | 154 +++++++++++++++++++++++++++++
>  arch/arm/mach-qcom/board.c                 |   1 +

I suspect the arm-soc folks would like us to split the mach-qcom
changes from the dts changes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
