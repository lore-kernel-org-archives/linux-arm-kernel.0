From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 7 Feb 2018 09:45:29 +0530
Subject: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180206185440.GJ9465@builder>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180206185440.GJ9465@builder>
Message-ID: <53642249-89c1-3fc0-8ad8-7a954b138bb2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/07/2018 12:24 AM, Bjorn Andersson wrote:
> On Thu 25 Jan 08:32 PST 2018, Rajendra Nayak wrote:
>> +		spmi_bus: qcom,spmi at c440000 {
> [..]
>> +		};
>> +
> 
> While we have the chance, please remove this empty line.

Will do. Thanks for the review.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
