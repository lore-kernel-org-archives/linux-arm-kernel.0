From: j.neuschaefer@gmx.net (Jonathan =?utf-8?Q?Neusch=C3=A4fer?=)
Date: Fri, 28 Apr 2017 20:58:25 +0200
Subject: [PATCH 4/5] arm64: dts: Add ipq8074 SoC and MTP board support
In-Reply-To: <1493373403-23462-5-git-send-email-varada@codeaurora.org>
References: <1493373403-23462-1-git-send-email-varada@codeaurora.org>
 <1493373403-23462-5-git-send-email-varada@codeaurora.org>
Message-ID: <20170428185825.75usyll55p3aclnm@latitude>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 28, 2017 at 03:26:42PM +0530, Varadarajan Narayanan wrote:
> Subject: [PATCH 4/5] arm64: dts: Add ipq8074 SoC and MTP board support

s/MTP/HK01/ ?

> Add initial device tree support for the Qualcomm IPQ8074 SoC and
> HK01 evaluation board.
> 
> Signed-off-by: Manoharan Vijaya Raghavan <mraghava@codeaurora.org>
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile         |   1 +
>  arch/arm64/boot/dts/qcom/ipq8074-hk01.dts |  48 ++++++++++
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi     | 153 ++++++++++++++++++++++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq8074.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index cc0f02d..7c6963e 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb

Maybe this list should be alphabetically sorted ('i' before 'm').
(I have no strong preference)


Thanks,
Jonathan Neusch?fer
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170428/00469211/attachment.sig>
