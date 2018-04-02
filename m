From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 2 Apr 2018 12:04:29 +0530
Subject: [PATCH v5 11/13] ARM: dts: ipq8074: Add peripheral nodes
In-Reply-To: <20180327174501.GN1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-12-git-send-email-sricharan@codeaurora.org>
 <20180327174501.GN1403@tuxbook-pro>
Message-ID: <67c43e89-c986-e548-c7f1-ce9ac095c509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/27/2018 11:15 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
>> +		serial_blsp0: serial at 78af000 {
> 
> Please try to have a single scheme for how you name your labels; this is
> serial0 or blsp1_uart1.
> 
> [..]
>> +		i2c_0: i2c at 78b6000 {
> 
> As in the previous patches, this is the 2nd i2c master in the SoC,
> please label it accordingly.

 ok, sure. will correct the label names uniformly.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
