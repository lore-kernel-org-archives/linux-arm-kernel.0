From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 18 Dec 2015 10:16:23 +0000
Subject: [PATCH 05/10] arm64: dts: r8a7795: Add pmu device nodes
In-Reply-To: <a6b6b478459be0c5614626ba6ac95df05a7fc5e9.1450401186.git.horms+renesas@verge.net.au>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
 <a6b6b478459be0c5614626ba6ac95df05a7fc5e9.1450401186.git.horms+renesas@verge.net.au>
Message-ID: <5673DCF7.1050008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/12/15 02:29, Simon Horman wrote:
> From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
>
> Enabling the performance monitor unit on r8a7795.
>
> Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
> Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 4d43cf31418f..b9229a49dabc 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -230,6 +230,18 @@
>   			power-domains = <&cpg>;
>   		};
>
> +		pmu {
> +			compatible = "arm,armv8-pmuv3";

Please use arm,cortex-a57-pmu to be more specific. IIRC I mentioned this
for some shmobile platform recently.

-- 
Regards,
Sudeep
