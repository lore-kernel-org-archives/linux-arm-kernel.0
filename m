From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 04 May 2015 10:47:33 +0900
Subject: [PATCH v2 3/8] clk: tegra: Fix inconsistent indenting
In-Reply-To: <20150501184655.GA29653@codeaurora.org>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
 <1430196383-9190-4-git-send-email-k.kozlowski@samsung.com>
 <20150501184655.GA29653@codeaurora.org>
Message-ID: <5546CFB5.3040105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.05.2015 03:46, Stephen Boyd wrote:
> On 04/28, Krzysztof Kozlowski wrote:
>> Fix the indentation - spaces used instead of tabs and actually wrong
>> number of spaces.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>   drivers/clk/tegra/clk-emc.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> What branch is this against? I don't see this in linux-next or
> clk-next.

It was rebased on next-20150427. But now I cannot find it in newer 
next... Could you skip these two patches then?

Best regards,
Krzysztof
