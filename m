From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 21 Jul 2017 08:20:39 -0500
Subject: [PATCH v2 1/4] net: phy: at803x: Document RGMII RX and TX clock
 delay issues
In-Reply-To: <051653a2-946f-6a0b-4cff-b403d1197038@sigmadesigns.com>
References: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
 <051653a2-946f-6a0b-4cff-b403d1197038@sigmadesigns.com>
Message-ID: <a9d3777c-1752-d79b-8302-d09c5f736a9f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/21/17 6:25 AM, Marc Gonzalez wrote:
> +	 * NB: This code assumes that RGMII RX clock delay is disabled
> +	 * at reset, but actually, RX clock delay is enabled at reset.

Could we change this to say, "RX clock delay is enabled at reset on some 
systems."?  Otherwise, it implies that the code is wrong 100% of the 
time and should be fixed, not documented.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
