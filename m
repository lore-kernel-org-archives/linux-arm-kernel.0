From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 May 2015 11:51:17 -0700
Subject: [PATCH v2 8/8] MIPS: Alchemy: Remove unneeded cast removing const
In-Reply-To: <1430196383-9190-9-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
 <1430196383-9190-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150501185117.GB29653@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28, Krzysztof Kozlowski wrote:
> Parent names in clock init data is now array of const pointers to const
> strings so the cast is not needed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I can take this through clk-next with an ack from Ralf.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
