From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 20 Jan 2015 11:38:22 -0800
Subject: [PATCHv7 2/2] arm64: add better page protections to arm64
In-Reply-To: <20150120184054.GJ25575@e104818-lin.cambridge.arm.com>
References: <1421276394-20402-1-git-send-email-lauraa@codeaurora.org>
 <1421276394-20402-3-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu8iGAPpR49EQKwmOZp2cHGdg8QJyoh2x1BB9uW6-S5L4g@mail.gmail.com>
 <54B9AC53.8020903@codeaurora.org>
 <20150120181453.GI25575@e104818-lin.cambridge.arm.com>
 <CAGXu5jLSQHC=R7gr+ZbgQ81K=v+zXS+uxyNofg9xGsovO8qssg@mail.gmail.com>
 <20150120184054.GJ25575@e104818-lin.cambridge.arm.com>
Message-ID: <54BEAEAE.8010700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/20/2015 10:40 AM, Catalin Marinas wrote:
> On Tue, Jan 20, 2015 at 06:19:23PM +0000, Kees Cook wrote:
>> If, however, only the name is stopping it from landing in arm64, then
>> I don't care what it's called. ;)
>
> Apart from couple of comments on this latest series, the patches look
> fine to me.
>

Did that message get sent out? I don't see it in my inbox.

> One question for Laura though: have the patches been tested it with:
>
> - 4-levels and 4KB pages?
> - 3-levels and 64KB pages?
>

Yes, just re-verified once again that both 4 level 4K pages and 3 level
64K pages work with this series.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
