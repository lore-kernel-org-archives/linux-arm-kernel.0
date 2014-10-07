From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 07 Oct 2014 20:28:16 +0100
Subject: [PATCH v2 04/15] clk: divider: Make generic for usage elsewhere
In-Reply-To: <54343038.2060007@codeaurora.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>
 <1409957256-23729-5-git-send-email-sboyd@codeaurora.org>
 <542EE5FE.9080806@codeaurora.org> <54342287.7020005@linaro.org>
 <54343038.2060007@codeaurora.org>
Message-ID: <54343ED0.6070200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/10/14 19:26, Stephen Boyd wrote:
> On 10/07/2014 10:27 AM, Srinivas Kandagatla wrote:
>> Hi Stephen,
>>
>> Just noticed this regression while testing the patch on Arndale board.
>>
>> https://bugs.linaro.org/show_bug.cgi?id=740
>
> If you return value it works correctly right?
>
Am really not sure, as this bug was originally reported as part of 
Linaro tracking kernel.

--srini
