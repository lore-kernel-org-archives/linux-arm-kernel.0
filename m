From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Jan 2017 14:56:12 -0800
Subject: [PATCH] clk: stm32f4: avoid uninitialized variable access
In-Reply-To: <CAK8P3a3ieV29jgh0jhioN3KjZCfP2drPAQme_+1oMuTTSiA4NQ@mail.gmail.com>
References: <20170111134107.3821564-1-arnd@arndb.de>
 <20170112220627.GQ17126@codeaurora.org>
 <CAK8P3a3ieV29jgh0jhioN3KjZCfP2drPAQme_+1oMuTTSiA4NQ@mail.gmail.com>
Message-ID: <3436f495-1c2b-b80b-2c0c-6956391bd43f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2017 02:42 PM, Arnd Bergmann wrote:
> On Thu, Jan 12, 2017 at 11:06 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Applied to clk-next. Seems I need to update my compiler to find
>> these warnings.
> I'm currently playing with gcc-7, which adds a lot of new warnings
> (including many false positives). gcc-6 was supposed to have better
> warnings than 5, but I didn't find the difference that noticeable. 5
> or 6 is probably best at the moment, and if you have at least 4.9
> there is no urgent need to upgrade.

Thanks. I'm on gcc-4.7. It's been a long time since I upgraded my cross
compiler.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
