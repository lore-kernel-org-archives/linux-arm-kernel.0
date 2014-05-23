From: davem@davemloft.net (David Miller)
Date: Fri, 23 May 2014 15:37:36 -0400 (EDT)
Subject: [PATCH 0/5] ks8851 DT updates
In-Reply-To: <537FA2A9.6050309@codeaurora.org>
References: <1400792413-21618-1-git-send-email-sboyd@codeaurora.org>
 <20140523.151502.1106354754894891974.davem@davemloft.net>
 <537FA2A9.6050309@codeaurora.org>
Message-ID: <20140523.153736.705710213824474686.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 23 May 2014 12:34:01 -0700

> On 05/23/14 12:15, David Miller wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>> Date: Thu, 22 May 2014 14:00:08 -0700
>>
>>> This set of patches properly documents the micrel ks8851 spi ethernet
>>> controller, converts to devm_regulator_get_optional() to make error
>>> paths slightly simpler, and finally adds supports for another
>>> optional regulator and a reset gpio.
>> Please do not submit patch sets that you expect different trees to
>> integrate, this is painful for maintainers to deal with.
>>
>> Instead, submit the changes separately.  One series for one
>> maintainer's tree, another for the other maintainer's tree.
>>
> 
> Ok. Shall I resend this series with the proper separation? Or can you
> ignore the first patch? There isn't any functional dependency, more just
> a checkpatch dependency which is not really all that important.

To avoid all ambiguity please resubmit the new series.
