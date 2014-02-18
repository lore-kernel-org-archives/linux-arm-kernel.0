From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Feb 2014 10:44:06 -0800
Subject: [PATCH v3 7/7] devicetree: bindings: Document PM8921/8058 PMICs
In-Reply-To: <20140213110619.GI32508@lee--X1>
References: <1389206270-3728-1-git-send-email-sboyd@codeaurora.org>
 <1389206270-3728-8-git-send-email-sboyd@codeaurora.org>
 <20140211092937.GG32042@lee--X1> <20140213053813.GB14769@codeaurora.org>
 <20140213110619.GI32508@lee--X1>
Message-ID: <5303A9F6.4030904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/14 03:06, Lee Jones wrote:
>> These match the #defines in that file. I'd like to be explicit
>> about the numbers to prevent people from thinking they have to
>> use #defines and to match what other irq controllers have done
>> (gic, atmel-aic, etc.)
> I believe people _do_ have to use the #defines? Is there a good reason
> for you not wanting to use them?
>

No, there isn't any requirement to use #defines in DT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
