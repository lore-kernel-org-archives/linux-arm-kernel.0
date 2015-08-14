From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Fri, 14 Aug 2015 11:54:48 -0700
Subject: [PATCH 2/3] ARM: qcom: add SMEM device node to IPQ806x dts
In-Reply-To: <55CD2EFE.8040606@codeaurora.org>
References: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
 <1439501620-24073-3-git-send-email-mathieu@codeaurora.org>
 <55CD2EFE.8040606@codeaurora.org>
Message-ID: <20150814185446.GB7516@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 04:57:50PM -0700, Stephen Boyd wrote:
> On 08/13/2015 02:33 PM, Mathieu Olivari wrote:
> >@@ -79,6 +79,15 @@
> >  			#hwlock-cells = <1>;
> >  		};
> >+
> >+		smem {
> >+			compatible = "qcom,smem";
> >+
> >+			memory-region = <&smem>;
> >+			reg = <0x41000000 0x4000>;
> 
> Does this reg property do something? I thought we were supposed to leave
> this out when not using the rpm msg ram. Also, if there's no reg, it should
> be at the root /.
Actually; no it doesn't do much. I'll remove it.
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
